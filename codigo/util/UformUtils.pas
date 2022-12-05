unit UformUtils;

interface

uses
  System.Classes,
  Vcl.Forms;

type
  TFormUtils = class(TObject)

  private

  protected

  public

    class procedure SetarFormularioPrincipal(PNovoFormulario: TForm);
    class procedure MostrarFormulario<T: TForm>(PFormlarioNovo: TForm;
      PFormularioAnterior: TForm = nil);
    class procedure AlinharCamposDBEdit<T: TForm>(PFormulario: TForm);

  end;

implementation

uses
  Vcl.DBCtrls;

{ TFormUtils }

class procedure TFormUtils.AlinharCamposDBEdit<T>(PFormulario: TForm);
var
  i: Integer;
begin
  // Varre todos os componentes do formul�rio e aqueles que foram do tipo TDBEdit
  // centraliza o texto
  for i := 0 to PFormulario.ComponentCount - 1 do
    if PFormulario.Components[i] is TDBEdit then
      TDBEdit(PFormulario.Components[i]).Field.Alignment := taLeftJustify;
end;

class procedure TFormUtils.MostrarFormulario<T>(PFormlarioNovo: TForm;
  PFormularioAnterior: TForm);
begin
  // Verifica se � necess�rio instanciar o novo formul�rio
  if not Assigned(PFormlarioNovo) then
  begin
    Application.CreateForm(T, PFormlarioNovo);
  end;

  // Caso o formul�rio anterior seja passado como par�metro o novo formul�rio
  // ser� tamb�m o novo MainForm da aplica��o
  if Assigned(PFormularioAnterior) then
  begin
    TFormUtils.SetarFormularioPrincipal(PFormlarioNovo);
    PFormlarioNovo.Show();
    PFormularioAnterior.Close;
  end
  else
    PFormlarioNovo.ShowModal();
end;

class procedure TFormUtils.SetarFormularioPrincipal(PNovoFormulario: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := PNovoFormulario;
end;

end.
