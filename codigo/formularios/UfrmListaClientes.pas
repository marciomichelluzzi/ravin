unit UfrmListaClientes;

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
  Vcl.ComCtrls,
  Vcl.StdCtrls, UfrmBotaoPrimario, UBotaoCancelar;

type
  TfrmListaClientes = class(TForm)
    lbxListaClientes: TListBox;
    frmBotaoPrimario1: TfrmBotaoPrimario;
    frmBotaoCancelar1: TfrmBotaoCancelar;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListaClientes: TfrmListaClientes;

implementation

{$R *.dfm}

procedure TfrmListaClientes.FormShow(Sender: TObject);
begin
  lbxListaClientes.Items.Add('asjuhasd');
end;

end.
