unit UnitCliente;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TCliente = class(TObject)
  private
    FID: Integer;
    FNome: string;
    FCPF: string;
    FEmail: string;
    FTelefone: string;
    FEndereco: string;
    FCidade: string;
    FEstado: string;
    FCEP: string;
    FDataCadastro: TDateTime;
  public
    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property CPF: string read FCPF write FCPF;
    property Email: string read FEmail write FEmail;
    property Telefone: string read FTelefone write FTelefone;
    property Endereco: string read FEndereco write FEndereco;
    property Cidade: string read FCidade write FCidade;
    property Estado: string read FEstado write FEstado;
    property CEP: string read FCEP write FCEP;
    property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;
  end;

implementation

end.
