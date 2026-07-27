unit UnitConexao;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Data.DB;

type
  TConexao = class(TObject)
  private
    FConexao: TFDConnection;
    FDriver: TFDPhysSQLiteDriverLink;
    class var FInstancia: TConexao;
  public
    constructor Create;
    destructor Destroy; override;
    function GetConexao: TFDConnection;
    procedure ConectarBancoDados;
    procedure CriarTabelaClientes;
    class function GetInstancia: TConexao;
  end;

implementation

{ TConexao }

var
  GConexao: TConexao = nil;

class function TConexao.GetInstancia: TConexao;
begin
  if not Assigned(GConexao) then
    GConexao := TConexao.Create;
  Result := GConexao;
end;

constructor TConexao.Create;
begin
  inherited Create;
  FDriver := TFDPhysSQLiteDriverLink.Create(nil);
  FConexao := TFDConnection.Create(nil);
  ConectarBancoDados;
end;

destructor TConexao.Destroy;
begin
  if Assigned(FConexao) then
    FreeAndNil(FConexao);
  if Assigned(FDriver) then
    FreeAndNil(FDriver);
  inherited Destroy;
end;

procedure TConexao.ConectarBancoDados;
begin
  try
    FConexao.DriverName := 'SQLite';
    FConexao.Params.Values['Database'] := ExtractFilePath(ParamStr(0)) + 'dados.db';
    FConexao.Connected := True;
    CriarTabelaClientes;
  except
    on E: Exception do
      raise Exception.Create('Erro ao conectar ao banco: ' + E.Message);
  end;
end;

procedure TConexao.CriarTabelaClientes;
var
  SQL: string;
begin
  try
    SQL := 'CREATE TABLE IF NOT EXISTS Clientes (' +
           'ID INTEGER PRIMARY KEY AUTOINCREMENT, ' +
           'Nome TEXT NOT NULL, ' +
           'CPF TEXT UNIQUE NOT NULL, ' +
           'Email TEXT, ' +
           'Telefone TEXT, ' +
           'Endereco TEXT, ' +
           'Cidade TEXT, ' +
           'Estado TEXT, ' +
           'CEP TEXT, ' +
           'DataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP' +
           ')';
    FConexao.ExecSQL(SQL);
  except
    on E: Exception do
      raise Exception.Create('Erro ao criar tabela: ' + E.Message);
  end;
end;

function TConexao.GetConexao: TFDConnection;
begin
  Result := FConexao;
end;

initialization

finalization
  if Assigned(GConexao) then
    FreeAndNil(GConexao);

end.
