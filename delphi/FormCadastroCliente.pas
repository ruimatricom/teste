unit FormCadastroCliente;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.Mask,
  Vcl.ComCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  UnitCliente,
  UnitClienteDAO,
  UnitConexao;

type
  TFormCadastroCliente = class(TForm)
    pnlTopo: TPanel;
    lblTitulo: TLabel;
    pnlCampos: TPanel;
    lblNome: TLabel;
    edtNome: TEdit;
    lblCPF: TLabel;
    edtCPF: TMaskEdit;
    lblEmail: TLabel;
    edtEmail: TEdit;
    lblTelefone: TLabel;
    edtTelefone: TMaskEdit;
    lblEndereco: TLabel;
    edtEndereco: TEdit;
    lblCidade: TLabel;
    edtCidade: TEdit;
    lblEstado: TLabel;
    cbEstado: TComboBox;
    lblCEP: TLabel;
    edtCEP: TMaskEdit;
    pnlBotoes: TPanel;
    btnNovo: TButton;
    btnSalvar: TButton;
    btnEditar: TButton;
    btnDeletar: TButton;
    btnCancelar: TButton;
    pnlGrid: TPanel;
    grdClientes: TDBGrid;
    dsClientes: TDataSource;
    qryClientes: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure grdClientesDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FClienteDAO: TClienteDAO;
    FModoEdicao: Boolean;
    FClienteAtual: TCliente;
    procedure LimparCampos;
    procedure HabilitarCampos(AHabilitar: Boolean);
    procedure CarregarGrid;
    procedure PreencherCampos(ACliente: TCliente);
    function ValidarCampos: Boolean;
    function CriarClienteDoFormulario: TCliente;
    procedure InicializarEstados;
  public
    { Public declarations }
  end;

var
  FormCadastroCliente: TFormCadastroCliente;

implementation

{$R *.dfm}

procedure TFormCadastroCliente.FormCreate(Sender: TObject);
begin
  try
    FClienteDAO := TClienteDAO.Create;
    FModoEdicao := False;
    FClienteAtual := nil;
    dsClientes.DataSet := qryClientes;
    grdClientes.DataSource := dsClientes;
    InicializarEstados;
    CarregarGrid;
    HabilitarCampos(False);
  except
    on E: Exception do
      ShowMessage('Erro ao inicializar: ' + E.Message);
  end;
end;

procedure TFormCadastroCliente.FormDestroy(Sender: TObject);
begin
  if Assigned(FClienteAtual) then
    FreeAndNil(FClienteAtual);
  if Assigned(FClienteDAO) then
    FreeAndNil(FClienteDAO);
end;

procedure TFormCadastroCliente.InicializarEstados;
begin
  cbEstado.Items.Add('AC');
  cbEstado.Items.Add('AL');
  cbEstado.Items.Add('AP');
  cbEstado.Items.Add('AM');
  cbEstado.Items.Add('BA');
  cbEstado.Items.Add('CE');
  cbEstado.Items.Add('DF');
  cbEstado.Items.Add('ES');
  cbEstado.Items.Add('GO');
  cbEstado.Items.Add('MA');
  cbEstado.Items.Add('MT');
  cbEstado.Items.Add('MS');
  cbEstado.Items.Add('MG');
  cbEstado.Items.Add('PA');
  cbEstado.Items.Add('PB');
  cbEstado.Items.Add('PR');
  cbEstado.Items.Add('PE');
  cbEstado.Items.Add('PI');
  cbEstado.Items.Add('RJ');
  cbEstado.Items.Add('RN');
  cbEstado.Items.Add('RS');
  cbEstado.Items.Add('RO');
  cbEstado.Items.Add('RR');
  cbEstado.Items.Add('SC');
  cbEstado.Items.Add('SP');
  cbEstado.Items.Add('SE');
  cbEstado.Items.Add('TO');
end;

procedure TFormCadastroCliente.LimparCampos;
begin
  edtNome.Clear;
  edtCPF.Clear;
  edtEmail.Clear;
  edtTelefone.Clear;
  edtEndereco.Clear;
  edtCidade.Clear;
  cbEstado.ItemIndex := -1;
  edtCEP.Clear;
end;

procedure TFormCadastroCliente.HabilitarCampos(AHabilitar: Boolean);
begin
  edtNome.Enabled := AHabilitar;
  edtCPF.Enabled := AHabilitar and not FModoEdicao;
  edtEmail.Enabled := AHabilitar;
  edtTelefone.Enabled := AHabilitar;
  edtEndereco.Enabled := AHabilitar;
  edtCidade.Enabled := AHabilitar;
  cbEstado.Enabled := AHabilitar;
  edtCEP.Enabled := AHabilitar;
  btnSalvar.Enabled := AHabilitar;
  btnNovo.Enabled := not AHabilitar;
  btnEditar.Enabled := not AHabilitar and (qryClientes.RecordCount > 0);
  btnDeletar.Enabled := not AHabilitar and (qryClientes.RecordCount > 0);
  btnCancelar.Enabled := AHabilitar;
end;

procedure TFormCadastroCliente.CarregarGrid;
begin
  try
    qryClientes.Close;
    FClienteDAO.Listar(qryClientes);
  except
    on E: Exception do
      ShowMessage('Erro ao carregar clientes: ' + E.Message);
  end;
end;

procedure TFormCadastroCliente.PreencherCampos(ACliente: TCliente);
begin
  if Assigned(ACliente) then
  begin
    edtNome.Text := ACliente.Nome;
    edtCPF.Text := ACliente.CPF;
    edtEmail.Text := ACliente.Email;
    edtTelefone.Text := ACliente.Telefone;
    edtEndereco.Text := ACliente.Endereco;
    edtCidade.Text := ACliente.Cidade;
    cbEstado.ItemIndex := cbEstado.Items.IndexOf(ACliente.Estado);
    edtCEP.Text := ACliente.CEP;
  end;
end;

function TFormCadastroCliente.ValidarCampos: Boolean;
begin
  Result := True;

  if Trim(edtNome.Text) = '' then
  begin
    ShowMessage('Nome é obrigatório!');
    edtNome.SetFocus;
    Exit(False);
  end;

  if Trim(edtCPF.Text) = '' then
  begin
    ShowMessage('CPF é obrigatório!');
    edtCPF.SetFocus;
    Exit(False);
  end;

  if (edtEmail.Text <> '') and (Pos('@', edtEmail.Text) = 0) then
  begin
    ShowMessage('Email inválido!');
    edtEmail.SetFocus;
    Exit(False);
  end;
end;

function TFormCadastroCliente.CriarClienteDoFormulario: TCliente;
begin
  Result := TCliente.Create;
  Result.Nome := edtNome.Text;
  Result.CPF := edtCPF.Text;
  Result.Email := edtEmail.Text;
  Result.Telefone := edtTelefone.Text;
  Result.Endereco := edtEndereco.Text;
  Result.Cidade := edtCidade.Text;
  Result.Estado := cbEstado.Text;
  Result.CEP := edtCEP.Text;
end;

procedure TFormCadastroCliente.btnNovoClick(Sender: TObject);
begin
  FModoEdicao := False;
  LimparCampos;
  HabilitarCampos(True);
  edtNome.SetFocus;
end;

procedure TFormCadastroCliente.btnSalvarClick(Sender: TObject);
var
  LCliente: TCliente;
begin
  if not ValidarCampos then
    Exit;

  try
    LCliente := CriarClienteDoFormulario;
    try
      if not FModoEdicao then
      begin
        FClienteDAO.Inserir(LCliente);
        ShowMessage('Cliente inserido com sucesso!');
      end
      else if Assigned(FClienteAtual) then
      begin
        LCliente.ID := FClienteAtual.ID;
        FClienteDAO.Atualizar(LCliente);
        ShowMessage('Cliente atualizado com sucesso!');
      end;

      LimparCampos;
      HabilitarCampos(False);
      CarregarGrid;
      if Assigned(FClienteAtual) then
      begin
        FreeAndNil(FClienteAtual);
        FClienteAtual := nil;
      end;
    finally
      LCliente.Free;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao salvar: ' + E.Message);
  end;
end;

procedure TFormCadastroCliente.btnEditarClick(Sender: TObject);
begin
  if qryClientes.RecordCount = 0 then
  begin
    ShowMessage('Selecione um cliente para editar!');
    Exit;
  end;

  try
    FModoEdicao := True;
    if Assigned(FClienteAtual) then
      FreeAndNil(FClienteAtual);

    FClienteAtual := FClienteDAO.BuscarPorID(qryClientes.FieldByName('ID').AsInteger);
    PreencherCampos(FClienteAtual);
    HabilitarCampos(True);
    edtNome.SetFocus;
  except
    on E: Exception do
      ShowMessage('Erro ao editar: ' + E.Message);
  end;
end;

procedure TFormCadastroCliente.btnDeletarClick(Sender: TObject);
begin
  if qryClientes.RecordCount = 0 then
  begin
    ShowMessage('Selecione um cliente para deletar!');
    Exit;
  end;

  if MessageDlg('Deseja realmente deletar este cliente?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      FClienteDAO.Deletar(qryClientes.FieldByName('ID').AsInteger);
      ShowMessage('Cliente deletado com sucesso!');
      CarregarGrid;
      LimparCampos;
    except
      on E: Exception do
        ShowMessage('Erro ao deletar: ' + E.Message);
    end;
  end;
end;

procedure TFormCadastroCliente.btnCancelarClick(Sender: TObject);
begin
  HabilitarCampos(False);
  LimparCampos;
  FModoEdicao := False;
  if Assigned(FClienteAtual) then
  begin
    FreeAndNil(FClienteAtual);
    FClienteAtual := nil;
  end;
end;

procedure TFormCadastroCliente.grdClientesDblClick(Sender: TObject);
begin
  btnEditarClick(nil);
end;

end.
