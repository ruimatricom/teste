# Guia de Compilação - Delphi 11

## 📋 Pré-requisitos

- Delphi 11 Enterprise ou Community Edition
- FireDAC instalado
- SQLite driver (vem com Delphi 11)

## 📁 Arquivos do Projeto

```
delphi/
├── CadastroClientes.dpr          # Arquivo principal do projeto
├── CadastroClientes.res          # Informações de versão
├── FormCadastroCliente.pas       # Formulário principal (código)
├── FormCadastroCliente.dfm       # Formulário principal (design)
├── UnitCliente.pas               # Classe modelo
├── UnitConexao.pas               # Conexão com banco
├── UnitClienteDAO.pas            # Acesso aos dados
└── README.md                      # Este arquivo
```

## 🚀 Passos para Compilar

### 1. Abrir o Projeto no Delphi 11

1. Abra o Delphi 11
2. Vá para **File > Open Project**
3. Navegue até a pasta `delphi`
4. Selecione o arquivo `CadastroClientes.dpr`
5. Clique em **Open**

### 2. Configurar Caminhos de Pesquisa

1. Vá para **Tools > Options**
2. Navegue para **Language > Delphi > Library**
3. Em **Library Path**, adicione a pasta do projeto:
   ```
   C:\caminho\para\delphi
   ```

### 3. Verificar FireDAC

1. Vá para **Tools > Options**
2. Navegue para **Third Party > FireDAC**
3. Certifique-se que SQLite está habilitado

### 4. Compilar o Projeto

**Opção 1: Usando o Menu**
- Pressione **F9** ou vá para **Run > Run**

**Opção 2: Compilar sem Executar**
- Pressione **Ctrl+F9** ou vá para **Project > Compile**

**Opção 3: Fazer Clean Build**
- Vá para **Project > Clean**
- Depois pressione **Shift+Ctrl+F9** ou **Project > Build All**

## ✅ Verificações Importantes

Antes de compilar, verifique:

1. **Todos os Units estão na mesma pasta:**
   - ✓ CadastroClientes.dpr
   - ✓ FormCadastroCliente.pas
   - ✓ FormCadastroCliente.dfm
   - ✓ UnitCliente.pas
   - ✓ UnitConexao.pas
   - ✓ UnitClienteDAO.pas

2. **FireDAC está instalado:**
   - Vá para **Component > Install Packages**
   - Procure por "FireDAC" na lista

3. **Componentes VCL disponíveis:**
   - TPanel, TLabel, TEdit, TMaskEdit, TButton, TComboBox
   - TDBGrid, TDataSource
   - TFDQuery, TFDConnection

## 🐛 Erros Comuns e Soluções

### Erro: "Undeclared identifier 'TFDQuery'"
**Solução:** FireDAC não está instalado ou configurado
- Verifique se o FireDAC está na lista de pacotes instalados
- Reinstale se necessário

### Erro: "Can't find SQLITE driver"
**Solução:** O driver SQLite não está registrado
- Vá para **Tools > Options > Third Party > FireDAC > Physical Drivers**
- Certifique-se que "SQLite" está checked

### Erro: "Unit 'UnitCliente' not found"
**Solução:** Os arquivos não estão no mesmo diretório
- Mova todos os .pas para a mesma pasta
- Atualize a biblioteca do projeto

### Erro: "Cannot open form file"
**Solução:** O arquivo .dfm está ausente ou corrompido
- Certifique-se que FormCadastroCliente.dfm existe
- Tente recriar o formulário se necessário

## 🔧 Configurações Recomendadas

### Project Options

1. **Application**
   - Title: "Cadastro de Clientes"

2. **Compiler**
   - Optimization: Enabled
   - Debug Info: Enabled (para desenvolvimento)

3. **Packages**
   - Runtime Packages: Deixar desmarcado para executável standalone

## 📦 Distribuindo o Executável

Após compilar com sucesso, o arquivo executável estará em:
```
delphi\Win32\Release\CadastroClientes.exe
```

Para distribuir, copie apenas o arquivo .exe. O SQLite está embarcado no Delphi.

## 🎯 Primeira Execução

1. **Execute o programa**
2. **Clique em "Novo"**
3. **Preencha os campos:**
   - Nome: João Silva
   - CPF: 123.456.789-10
   - Email: joao@email.com
   - Telefone: (11)99999-9999
   - Endereço: Rua Exemplo, 123
   - Cidade: São Paulo
   - Estado: SP
   - CEP: 01000-000
4. **Clique em "Salvar"**

O banco de dados `dados.db` será criado automaticamente na pasta do executável.

## 💡 Dicas de Desenvolvimento

1. **Use Ctrl+Space** para autocomplete
2. **Use F1** para ajuda sobre componentes
3. **Use View > Messages** para ver erros de compilação
4. **Use View > Call Stack** para debug
5. **Coloque breakpoints com F5** para debugar

## 📞 Suporte

Se encontrar problemas:
1. Verifique todos os pré-requisitos
2. Tente fazer um Clean Build
3. Reinicie o Delphi
4. Verifique os paths do projeto

---

**Pronto para compilar!** 🎉
