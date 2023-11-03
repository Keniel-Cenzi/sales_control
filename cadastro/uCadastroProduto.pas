unit uCadastroProduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.ListBox, FMX.Layouts,
  FMX.Objects;

type
  TfrCadastro = class(TForm)
    StyleBook1: TStyleBook;
    ltMenu: TLayout;
    rtMenu: TRectangle;
    ltbMenu: TListBox;
    mnCadastro: TListBoxItem;
    lbCadastro: TLabel;
    mnConsulta: TListBoxItem;
    lbConsultas: TLabel;
    mnSair: TListBoxItem;
    lbSair: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frCadastro: TfrCadastro;

implementation

{$R *.fmx}

end.
