program Ravin;

uses
  Vcl.Forms,
  UfrmCartaoPainelGestao in '..\codigo\frames\UfrmCartaoPainelGestao.pas' {frmCartaoPainelControle: TFrame},
  UfrmLogomarca in '..\codigo\frames\UfrmLogomarca.pas' {frmLogo: TFrame},
  UfrmItemMenu in '..\codigo\frames\UfrmItemMenu.pas' {frmMenuItem: TFrame},
  UdmRavin in '..\codigo\database\UdmRavin.pas' {dmRavin: TDataModule},
  UfrmSplash in '..\codigo\formularios\UfrmSplash.pas' {frmSplash},
  UfrmMesas in '..\codigo\formularios\UfrmMesas.pas' {frmMesas},
  UfrmSobre in '..\codigo\formularios\UfrmSobre.pas' {frmSobre},
  UfrmProdutos in '..\codigo\formularios\UfrmProdutos.pas' {frmProdutos},
  UfrmPainelGestao in '..\codigo\formularios\UfrmPainelGestao.pas' {frmPainelGestao},
  UfrmComandas in '..\codigo\formularios\UfrmComandas.pas' {frmComandas},
  UResourceUtils in '..\codigo\util\UResourceUtils.pas',
  UfrmAutenticar in '..\codigo\formularios\UfrmAutenticar.pas' {frmAutenticar},
  UfrmBotaoPrimario in '..\codigo\frames\UfrmBotaoPrimario.pas' {frmBotaoPrimario: TFrame},
  UfrmBotaoSecundario in '..\codigo\frames\UfrmBotaoSecundario.pas' {frmBotaoSecundario: TFrame},
  Uusuario in '..\codigo\modelos\Uusuario.pas',
  UusuarioDao in '..\codigo\dao\UusuarioDao.pas',
  UfrmRegistrar in '..\codigo\formularios\UfrmRegistrar.pas' {frmRegistrar};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TdmRavin, dmRavin);
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmRegistrar, frmRegistrar);
  Application.Run;
end.
