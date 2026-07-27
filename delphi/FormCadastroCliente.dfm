object FormCadastroCliente: TFormCadastroCliente
  Left = 0
  Top = 0
  Caption = 'Cadastro de Clientes'
  ClientHeight = 600
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 1000
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    Color = clHighlight
    ParentBackground = False
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 16
      Top = 16
      Width = 270
      Height = 19
      Caption = 'CADASTRO DE CLIENTES'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlCampos: TPanel
    Left = 0
    Top = 50
    Width = 1000
    Height = 250
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 10
    TabOrder = 1
    object lblNome: TLabel
      Left = 10
      Top = 10
      Width = 37
      Height = 13
      Caption = 'Nome:'
    end
    object edtNome: TEdit
      Left = 10
      Top = 27
      Width = 400
      Height = 21
      TabOrder = 0
    end
    object lblCPF: TLabel
      Left = 430
      Top = 10
      Width = 25
      Height = 13
      Caption = 'CPF:'
    end
    object edtCPF: TMaskEdit
      Left = 430
      Top = 27
      Width = 150
      Height = 21
      EditMask = '###.###.###-##;1;_'
      MaxLength = 14
      TabOrder = 1
    end
    object lblEmail: TLabel
      Left = 10
      Top = 60
      Width = 35
      Height = 13
      Caption = 'Email:'
    end
    object edtEmail: TEdit
      Left = 10
      Top = 77
      Width = 300
      Height = 21
      TabOrder = 2
    end
    object lblTelefone: TLabel
      Left = 330
      Top = 60
      Width = 52
      Height = 13
      Caption = 'Telefone:'
    end
    object edtTelefone: TMaskEdit
      Left = 330
      Top = 77
      Width = 150
      Height = 21
      EditMask = '(##)#####-####;1;_'
      MaxLength = 15
      TabOrder = 3
    end
    object lblEndereco: TLabel
      Left = 10
      Top = 110
      Width = 53
      Height = 13
      Caption = 'Endereco:'
    end
    object edtEndereco: TEdit
      Left = 10
      Top = 127
      Width = 470
      Height = 21
      TabOrder = 4
    end
    object lblCidade: TLabel
      Left = 10
      Top = 160
      Width = 37
      Height = 13
      Caption = 'Cidade:'
    end
    object edtCidade: TEdit
      Left = 10
      Top = 177
      Width = 250
      Height = 21
      TabOrder = 5
    end
    object lblEstado: TLabel
      Left = 280
      Top = 160
      Width = 37
      Height = 13
      Caption = 'Estado:'
    end
    object cbEstado: TComboBox
      Left = 280
      Top = 177
      Width = 80
      Height = 21
      Style = csDropDownList
      TabOrder = 6
    end
    object lblCEP: TLabel
      Left = 390
      Top = 160
      Width = 25
      Height = 13
      Caption = 'CEP:'
    end
    object edtCEP: TMaskEdit
      Left = 390
      Top = 177
      Width = 90
      Height = 21
      EditMask = '#####-###;1;_'
      MaxLength = 9
      TabOrder = 7
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 300
    Width = 1000
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 2
    object btnNovo: TButton
      Left = 10
      Top = 10
      Width = 80
      Height = 30
      Caption = '&Novo'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnSalvar: TButton
      Left = 100
      Top = 10
      Width = 80
      Height = 30
      Caption = '&Salvar'
      Enabled = False
      TabOrder = 1
      OnClick = btnSalvarClick
    end
    object btnEditar: TButton
      Left = 190
      Top = 10
      Width = 80
      Height = 30
      Caption = '&Editar'
      TabOrder = 2
      OnClick = btnEditarClick
    end
    object btnDeletar: TButton
      Left = 280
      Top = 10
      Width = 80
      Height = 30
      Caption = '&Deletar'
      TabOrder = 3
      OnClick = btnDeletarClick
    end
    object btnCancelar: TButton
      Left = 370
      Top = 10
      Width = 80
      Height = 30
      Caption = '&Cancelar'
      Enabled = False
      TabOrder = 4
      OnClick = btnCancelarClick
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 350
    Width = 1000
    Height = 250
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 3
    object grdClientes: TDBGrid
      Left = 5
      Top = 5
      Width = 990
      Height = 240
      Align = alClient
      DataSource = dsClientes
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = grdClientesDblClick
    end
  end
  object dsClientes: TDataSource
    DataSet = qryClientes
    Left = 920
    Top = 400
  end
  object qryClientes: TFDQuery
    Left = 850
    Top = 400
  end
end
