program CadastroClientes;

uses
  Vcl.Forms,
  FormCadastroCliente in 'FormCadastroCliente.pas' {FormCadastroCliente},
  UnitCliente in 'UnitCliente.pas',
  UnitConexao in 'UnitConexao.pas',
  UnitClienteDAO in 'UnitClienteDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCadastroCliente, FormCadastroCliente);
  Application.Run;
end.
