unit UnitClienteDAO;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  Data.DB,
  UnitCliente,
  UnitConexao;

type
  TClienteDAO = class(TObject)
  private
    FConexao: TFDConnection;
  public
    constructor Create;
    procedure Inserir(ACliente: TCliente);
    procedure Atualizar(ACliente: TCliente);
    procedure Deletar(AID: Integer);
    procedure Listar(AQuery: TFDQuery);
    function BuscarPorID(AID: Integer): TCliente;
    function ValidarCPF(ACPF: string): Boolean;
  end;

implementation

{ TClienteDAO }

constructor TClienteDAO.Create;
begin
  inherited Create;
  FConexao := TConexao.GetInstancia.GetConexao;
end;

procedure TClienteDAO.Inserir(ACliente: TCliente);
var
  Query: TFDQuery;
begin
  try
    if not ValidarCPF(ACliente.CPF) then
      raise Exception.Create('CPF inválido!');

    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FConexao;
      Query.SQL.Text := 'INSERT INTO Clientes (Nome, CPF, Email, Telefone, Endereco, Cidade, Estado, CEP) ' +
                        'VALUES (:NOME, :CPF, :EMAIL, :TELEFONE, :ENDERECO, :CIDADE, :ESTADO, :CEP)';
      Query.ParamByName('NOME').Value := ACliente.Nome;
      Query.ParamByName('CPF').Value := ACliente.CPF;
      Query.ParamByName('EMAIL').Value := ACliente.Email;
      Query.ParamByName('TELEFONE').Value := ACliente.Telefone;
      Query.ParamByName('ENDERECO').Value := ACliente.Endereco;
      Query.ParamByName('CIDADE').Value := ACliente.Cidade;
      Query.ParamByName('ESTADO').Value := ACliente.Estado;
      Query.ParamByName('CEP').Value := ACliente.CEP;
      Query.ExecSQL;
    finally
      Query.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create('Erro ao inserir cliente: ' + E.Message);
  end;
end;

procedure TClienteDAO.Atualizar(ACliente: TCliente);
var
  Query: TFDQuery;
begin
  try
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FConexao;
      Query.SQL.Text := 'UPDATE Clientes SET Nome = :NOME, Email = :EMAIL, Telefone = :TELEFONE, ' +
                        'Endereco = :ENDERECO, Cidade = :CIDADE, Estado = :ESTADO, CEP = :CEP WHERE ID = :ID';
      Query.ParamByName('ID').Value := ACliente.ID;
      Query.ParamByName('NOME').Value := ACliente.Nome;
      Query.ParamByName('EMAIL').Value := ACliente.Email;
      Query.ParamByName('TELEFONE').Value := ACliente.Telefone;
      Query.ParamByName('ENDERECO').Value := ACliente.Endereco;
      Query.ParamByName('CIDADE').Value := ACliente.Cidade;
      Query.ParamByName('ESTADO').Value := ACliente.Estado;
      Query.ParamByName('CEP').Value := ACliente.CEP;
      Query.ExecSQL;
    finally
      Query.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create('Erro ao atualizar cliente: ' + E.Message);
  end;
end;

procedure TClienteDAO.Deletar(AID: Integer);
var
  Query: TFDQuery;
begin
  try
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FConexao;
      Query.SQL.Text := 'DELETE FROM Clientes WHERE ID = :ID';
      Query.ParamByName('ID').Value := AID;
      Query.ExecSQL;
    finally
      Query.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create('Erro ao deletar cliente: ' + E.Message);
  end;
end;

procedure TClienteDAO.Listar(AQuery: TFDQuery);
begin
  try
    AQuery.Connection := FConexao;
    AQuery.SQL.Text := 'SELECT ID, Nome, CPF, Email, Telefone, Endereco, Cidade, Estado, CEP, DataCadastro FROM Clientes ORDER BY Nome';
    AQuery.Open;
  except
    on E: Exception do
      raise Exception.Create('Erro ao listar clientes: ' + E.Message);
  end;
end;

function TClienteDAO.BuscarPorID(AID: Integer): TCliente;
var
  Query: TFDQuery;
begin
  Result := nil;
  try
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FConexao;
      Query.SQL.Text := 'SELECT * FROM Clientes WHERE ID = :ID';
      Query.ParamByName('ID').Value := AID;
      Query.Open;

      if not Query.Eof then
      begin
        Result := TCliente.Create;
        Result.ID := Query.FieldByName('ID').AsInteger;
        Result.Nome := Query.FieldByName('Nome').AsString;
        Result.CPF := Query.FieldByName('CPF').AsString;
        Result.Email := Query.FieldByName('Email').AsString;
        Result.Telefone := Query.FieldByName('Telefone').AsString;
        Result.Endereco := Query.FieldByName('Endereco').AsString;
        Result.Cidade := Query.FieldByName('Cidade').AsString;
        Result.Estado := Query.FieldByName('Estado').AsString;
        Result.CEP := Query.FieldByName('CEP').AsString;
        Result.DataCadastro := Query.FieldByName('DataCadastro').AsDateTime;
      end;
    finally
      Query.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar cliente: ' + E.Message);
  end;
end;

function TClienteDAO.ValidarCPF(ACPF: string): Boolean;
var
  i, Soma, Resto: Integer;
  Digito1, Digito2: Integer;
  CPFNumeros: string;
begin
  Result := False;
  
  CPFNumeros := StringReplace(ACPF, '.', '', [rfReplaceAll]);
  CPFNumeros := StringReplace(CPFNumeros, '-', '', [rfReplaceAll]);

  if Length(CPFNumeros) <> 11 then
    Exit;

  // Verificar se todos os caracteres são dígitos
  for i := 1 to Length(CPFNumeros) do
  begin
    if not (CPFNumeros[i] in ['0'..'9']) then
      Exit;
  end;

  // Calcular primeiro dígito verificador
  Soma := 0;
  for i := 0 to 8 do
    Soma := Soma + (StrToInt(CPFNumeros[i + 1]) * (10 - i));

  Resto := Soma mod 11;
  if Resto < 2 then
    Digito1 := 0
  else
    Digito1 := 11 - Resto;

  // Calcular segundo dígito verificador
  Soma := 0;
  for i := 0 to 9 do
    Soma := Soma + (StrToInt(CPFNumeros[i + 1]) * (11 - i));

  Resto := Soma mod 11;
  if Resto < 2 then
    Digito2 := 0
  else
    Digito2 := 11 - Resto;

  Result := (StrToInt(CPFNumeros[10]) = Digito1) and (StrToInt(CPFNumeros[11]) = Digito2);
end;

end.
