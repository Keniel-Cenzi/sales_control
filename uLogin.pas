unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects,
  uClasseControladora;

type
  TfrLogin = class(TForm)
    ltLogin: TLayout;
    edUsuario: TEdit;
    edSenha: TEdit;
    rcLogin: TRectangle;
    imgLogo: TImage;
    lbLogin: TLabel;
    Style: TStyleBook;
    btnLogin: TButton;
    procedure edUsuarioEnter(Sender: TObject);
    procedure edSenhaEnter(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure edUsuarioExit(Sender: TObject);
    procedure edSenhaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    classeControladora: TClasseControladora;
  public
    { Public declarations }
  end;

var
  frLogin: TfrLogin;

implementation

{$R *.fmx}

uses uPrincipal;

procedure TfrLogin.btnLoginClick(Sender: TObject);
var
  wMsg           : string;
  wFocusUsuario  : boolean;
begin
  wMsg := '';
  wFocusUsuario  := false;

  if (wMsg = '') and ((edUsuario.Text = '') or (AnsiSameText(edUsuario.Text,
    'Usu�rio'))) then
  begin
    wMsg := 'Usu�rio inv�lido';
    wFocusUsuario := true;
  end;

  if (wMsg = '') and ((edSenha.Text = '') or (AnsiSameText(edSenha.Text, 'Senha'))) then
    wMsg := 'Senha inv�lida';

  if wMsg <> '' then
  begin
    MessageDlg(wMsg, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);

    if wFocusUsuario then
      edUsuario.SetFocus
    else
      edSenha.SetFocus;

    Exit;
  end;

  // Se chegar at� aqui, tem que tentar autenticar
  classeControladora.pFazAutenticacaoUser(edUsuario.Text, edSenha.Text, Self);
end;

procedure TfrLogin.edSenhaEnter(Sender: TObject);
begin
  if AnsiSameText(edSenha.Text, 'Senha') then
  begin
    edSenha.Text := '';
    edSenha.Password := true;
  end;
end;

procedure TfrLogin.edUsuarioEnter(Sender: TObject);
begin
  edUsuario.Text := '';
end;

procedure TfrLogin.edUsuarioExit(Sender: TObject);
begin
  if (not AnsiSameText(edSenha.Text, 'Usu�rio')) and (edUsuario.Text = '') then
    edUsuario.Text := 'Usu�rio';
end;

procedure TfrLogin.FormCreate(Sender: TObject);
begin
  classeControladora := TClasseControladora.Create(Self);
end;

procedure TfrLogin.edSenhaExit(Sender: TObject);
begin
  if (not AnsiSameText(edSenha.Text, 'Senha')) and (edSenha.Text = '') then
  begin
    edSenha.Text     := 'Senha';
    edSenha.Password := false;
  end;
end;

end.
