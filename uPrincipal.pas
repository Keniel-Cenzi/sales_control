unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.Layouts, FMX.Objects,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, uCadastroProduto,
  FMX.Memo.Types, FMX.DateTimeCtrls, FMX.Memo, FMX.Edit, uClasseControladora,
  FMX.DialogService, FMX.Ani, IdHTTP, REST.Json, IdBaseComponent, IdComponent,
  IdTCPClient, System.JSON, IdSSLOpenSSL, Character, IdStack, IdTCPConnection,
  DBXDevartOracle, Data.FMTBcd, Data.DB, Data.SqlExpr, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.FMXUI.Wait,
  FireDAC.Comp.Client, FMX.ComboEdit;

type
  TfrPrincipal = class(TForm)
    ltCabecalho: TLayout;
    ltMenu: TLayout;
    rtMenu: TRectangle;
    ltbMenu: TListBox;
    mnCadastro: TListBoxItem;
    mnConsulta: TListBoxItem;
    lbCadastro: TLabel;
    lbConsultas: TLabel;
    ltPrincipal: TLayout;
    ltImgLogo: TLayout;
    ltSaldo: TLayout;
    ltUser: TLayout;
    rcImgLogo: TRectangle;
    rcSaldo: TRectangle;
    rcUser: TRectangle;
    imgLogo: TImage;
    lbSaldo: TLabel;
    rcConsulta: TRectangle;
    imgUser: TImage;
    ltDadosUser: TLayout;
    rcDadosUser: TRectangle;
    lbNomeUsuario: TLabel;
    lbUltimoLogin: TLabel;
    mnSair: TListBoxItem;
    lbSair: TLabel;
    grListaProdutos: TGrid;
    columnProduto: TStringColumn;
    dataVenda: TDateColumn;
    descProduto: TStringColumn;
    valorProduto: TFloatColumn;
    rcCadastro: TRectangle;
    edValorProduto: TEdit;
    mmDescricao: TMemo;
    Z: TDateEdit;
    lbProdutos: TLabel;
    lbDataCadastro: TLabel;
    lbValorProduto: TLabel;
    lbDescricaoProduto: TLabel;
    btnCancelarProd: TButton;
    btnCadastrarProd: TButton;
    RectAnimation1: TRectAnimation;
    mmCadUser: TListBoxItem;
    lbCadUser: TLabel;
    rcCadUsuario: TRectangle;
    lbNome: TLabel;
    Edit1: TEdit;
    lbSenha: TLabel;
    edSenha: TEdit;
    lbEmail: TLabel;
    edEmail: TEdit;
    lbCEP: TLabel;
    edCep: TEdit;
    lbLogradouro: TLabel;
    edLogradouro: TEdit;
    lbBairro: TLabel;
    edBairro: TEdit;
    edCidade: TEdit;
    lbCidade: TLabel;
    Label1: TLabel;
    edUF: TEdit;
    btCadastrarUser: TButton;
    btCancelarCadUser: TButton;
    IdHTTP1: TIdHTTP;
    lbNumero: TLabel;
    edNumero: TEdit;
    cbProdutos: TComboEdit;
    mnCadVenda: TListBoxItem;
    lbCadVenda: TLabel;
    rcCadVenda: TRectangle;
    edValorVenda: TEdit;
    mmDescProdutoVenda: TMemo;
    cbDataVenda: TDateEdit;
    lbProdutoVenda: TLabel;
    lbDataVenda: TLabel;
    lbValorProdutoVenda: TLabel;
    lbDescProdutoVenda: TLabel;
    btCancelarVenda: TButton;
    btCadastrarVenda: TButton;
    RectAnimation2: TRectAnimation;
    cbProdutoVenda: TComboEdit;
    procedure mnSairClick(Sender: TObject);
    procedure mnCadastroClick(Sender: TObject);
    procedure mnConsultaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgUserClick(Sender: TObject);
    procedure edValorProdutoTyping(Sender: TObject);
    procedure mmCadUserClick(Sender: TObject);
    procedure edCepExit(Sender: TObject);
    procedure btCancelarCadUserClick(Sender: TObject);
    procedure btnCancelarProdClick(Sender: TObject);
    procedure mnCadVendaClick(Sender: TObject);
  private
    { Private declarations }
    classeControladora : TClasseControladora;

    function fFecharAplicacao : Boolean;
    function sohNumeros(const cep: string) : boolean;
  public
    { Public declarations }
  end;

var
  frPrincipal: TfrPrincipal;

implementation

{$R *.fmx}

procedure TfrPrincipal.btCancelarCadUserClick(Sender: TObject);
begin
  classeControladora.controlaRetangulos(rcConsulta.Tag);
  classeControladora.ControlaCorMenus(lbConsultas.Tag);
end;

procedure TfrPrincipal.btnCancelarProdClick(Sender: TObject);
begin
  classeControladora.controlaRetangulos(rcConsulta.Tag);
   classeControladora.ControlaCorMenus(lbConsultas.Tag);
end;

procedure TfrPrincipal.edCepExit(Sender: TObject);
var
  CEP,
  Response    : string;
  AddressInfo : TJSONObject;
begin
  IdHTTP1.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(IdHTTP1);
  TIdSSLIOHandlerSocketOpenSSL(IdHTTP1.IOHandler).SSLOptions.SSLVersions := [sslvTLSv1_2];

  CEP := Trim(edCep.Text);

  try
    Response := IdHTTP1.Get('https://viacep.com.br/ws/' + CEP + '/json/');
  except
    MessageDlg('CEP inválido!', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOk], 0);
    Exit;
  end;

  AddressInfo := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Response), 0) as TJSONObject;

  edLogradouro.Text	:= AddressInfo.GetValue('logradouro').Value;
  edBairro.Text     := AddressInfo.GetValue('bairro').Value;
  edCidade.Text	    := AddressInfo.GetValue('localidade').Value;
  edUF.Text	        := AddressInfo.GetValue('uf').Value;
end;

procedure TfrPrincipal.edValorProdutoTyping(Sender: TObject);
begin
   TThread.Queue(nil,
    procedure
    var
      txt, txt2: string;
      x: integer;
    begin
      txt := edValorProduto.Text;
      txt2 := '';
      for x := 0 to Length(txt) - 1 do
        if (txt.Chars[x] In ['0' .. '9']) then
          txt2 := txt2 + txt.Chars[x];

      txt := txt2;
      edValorProduto.Text := 'R$ ' + FormatFloat('#,##0.00', StrToFloatDef(txt, 0) / 100);
      edValorProduto.GoToTextEnd;
    end);
end;

function TfrPrincipal.fFecharAplicacao: Boolean;
begin
  Result := false;

  if (MessageDlg('Tem certeza que deseja encerrar o sistema?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes) then
     Result := true;
end;

procedure TfrPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (not fFecharAplicacao) then
     Action := TCloseAction.caNone
  else
     begin
       if Assigned(classeControladora) then
         FreeAndNil(classeControladora);

       Application.terminate;
     end;
end;

procedure TfrPrincipal.FormCreate(Sender: TObject);
begin
  classeControladora := TClasseControladora.Create(Self);

  classeControladora.AtualizaLabelsPrincipal;    
  classeControladora.controlaRetangulos(rcConsulta.Tag);
  classeControladora.ControlaCorMenus(lbConsultas.Tag);
end;

procedure TfrPrincipal.imgUserClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(Self);
  try
    OpenDialog.Filter := 'Imagens|*.jpg;*.jpeg;*.png;*.bmp|Todos os arquivos|*.*';
    if OpenDialog.Execute then
    begin
      if FileExists(OpenDialog.FileName) then
        imgUser.Bitmap.LoadFromFile(OpenDialog.FileName);
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TfrPrincipal.mmCadUserClick(Sender: TObject);
begin
  classeControladora.controlaRetangulos(rcCadUsuario.Tag);
  classeControladora.ControlaCorMenus(lbCadUser.Tag);
end;

procedure TfrPrincipal.mnCadastroClick(Sender: TObject);
begin
  classeControladora.controlaRetangulos(rcCadastro.Tag);
  classeControladora.ControlaCorMenus(lbCadastro.Tag);
end;

procedure TfrPrincipal.mnCadVendaClick(Sender: TObject);
begin
  classeControladora.controlaRetangulos(rcCadVenda.Tag);
  classeControladora.ControlaCorMenus(lbCadVenda.Tag);
end;

procedure TfrPrincipal.mnConsultaClick(Sender: TObject);
begin
  classeControladora.controlaRetangulos(rcConsulta.Tag);
  classeControladora.ControlaCorMenus(lbConsultas.Tag);
end;

procedure TfrPrincipal.mnSairClick(Sender: TObject);
begin
  Close;
end;

function TfrPrincipal.sohNumeros(const cep: string): boolean;
var
  Charac: Char;
begin
  Result := true;

  for Charac in cep do
  begin
    if not TCharacter.IsDigit(Charac) then
    begin
      Result := false;
      Break;
    end;
  end;
end;

end.
