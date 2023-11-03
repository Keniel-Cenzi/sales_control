unit uClasseControladora;

interface

uses
  System.SysUtils, FMX.Forms, FMX.Edit, FMX.Memo, FMX.ListBox, FMX.StdCtrls, FMX.Objects, System.Classes;

type
  TClasseControladora = class
    private
     wFormPrincipal : TForm;

     function GetDadosUsuarioLogado : string;
     function GetDadosValorMensal(mes : integer) : String;
     function GetDataUltimoLogin : string;
    public
     wNomeUsuario       : String;
     wUsarioAutenticado : Boolean;

     constructor Create(formPrincipal : TForm);

     procedure AtualizaLabelsPrincipal;
     procedure controlaRetangulos(tagRetangulo : integer);
     procedure pFazAutenticacaoUser(prUsuario : string; prSenha : string; formLogin: TForm);
     procedure ControlaCorMenus(tagMenu : Integer);
  end;

implementation

uses uPrincipal;

procedure TClasseControladora.AtualizaLabelsPrincipal;
var
  wI : Integer;

  wLabelNomeUsuario,
  wLabelUltimoLogin,
  wLabelValorMensal : TComponent;
begin
  wLabelNomeUsuario := wFormPrincipal.FindComponent('lbNomeUsuario');
  wLabelUltimoLogin := wFormPrincipal.FindComponent('lbUltimoLogin');
  wLabelValorMensal := wFormPrincipal.FindComponent('lbSaldo');

  if Assigned(wLabelNomeUsuario) then
     TLabel(wLabelNomeUsuario).Text := GetDadosUsuarioLogado;

  if Assigned(wLabelUltimoLogin) then
     TLabel(wLabelUltimoLogin).Text := GetDataUltimoLogin;

  if Assigned(wLabelValorMensal) then
     TLabel(wLabelValorMensal).Text := GetDadosValorMensal(0);
end;

procedure TClasseControladora.ControlaCorMenus(tagMenu : Integer);
var
  wI : Integer;
begin
   for wI := 0 to wFormPrincipal.ComponentCount -1 do
      begin
        if (wFormPrincipal.Components[wI] is TLabel) then
           begin
             if (TLabel(wFormPrincipal.Components[wI]).Tag <> 0) then
             begin
               if TLabel(wFormPrincipal.Components[wI]).Tag = tagMenu then
                  TLabel(wFormPrincipal.Components[wI]).TextSettings.FontColor := $FF32C6FF
               else
                  TLabel(wFormPrincipal.Components[wI]).TextSettings.FontColor := $FF9A9191;             
             end;             
           end;
      end;
end;

procedure TClasseControladora.controlaRetangulos(tagRetangulo : integer);
var
  wRetanguloConsulta,
  wRetanguloCadastro,
  wRetanguloCadUser  : TComponent;

  wI : Integer;
begin    
     for wI := 0 to wFormPrincipal.ComponentCount -1 do
      begin
        if (wFormPrincipal.Components[wI] is TRectangle) then
           begin
             if (TRectangle(wFormPrincipal.Components[wI]).Tag <> 0) then
             begin
               if TRectangle(wFormPrincipal.Components[wI]).Tag = tagRetangulo then
                  TRectangle(wFormPrincipal.Components[wI]).Visible	:= true
               else
                  TRectangle(wFormPrincipal.Components[wI]).Visible	:= false;
             end;             
           end;
      end;                                                                   
end;

constructor TClasseControladora.Create(formPrincipal : TForm);
begin
  wFormPrincipal     := formPrincipal;
  wNomeUsuario       := '';
  wUsarioAutenticado := false;
end;

function TClasseControladora.GetDadosUsuarioLogado: string;
begin
  //posteriormente essas informações serão buscadas do bando de dados.
  result := '  Usuário: Keniel Cenzi';
end;

function TClasseControladora.GetDadosValorMensal(mes: integer): String;
begin
  //posteriormente essas informações serão buscadas do bando de dados.
  result := '  Saldo Janeiro: R$ 45.000,00';
end;

function TClasseControladora.GetDataUltimoLogin: string;
begin
  result := '  Último login: ' + DateTimeToStr(now);
end;

procedure TClasseControladora.pFazAutenticacaoUser(prUsuario : string; prSenha : string; formLogin: TForm);
var
  wFormPrincipal : TfrPrincipal;
begin
  wFormPrincipal := TfrPrincipal.Create(formLogin);
  wFormPrincipal.Show;

  formLogin.Hide;
end;

end.
