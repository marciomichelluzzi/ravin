unit UdmRavin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs;

type
  TdmRavin = class(TDataModule)
    cnxBancoDeDados: TFDConnection;
    drvBancoDeDados: TFDPhysMySQLDriverLink;
    wtcBancoDeDados: TFDGUIxWaitCursor;
    FDQuery1: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnxBancoDeDadosBeforeConnect(Sender: TObject);
    procedure cnxBancoDeDadosAfterConnect(Sender: TObject);
  private
    { Private declarations }
    procedure CriarTabelas();
    procedure InserirDados();
  public
    { Public declarations }
  end;

var
  dmRavin: TdmRavin;

implementation

uses UresourceUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmRavin.cnxBancoDeDadosAfterConnect(Sender: TObject);
var
  LCaminhoBaseDados: String;
  LCriarBaseDados: Boolean;
begin
  LCaminhoBaseDados := 'C:\ProgramData\MySQL' +
    '\MySQL Server 8.0\Data\ravin\pessoa.ibd';
  LCriarBaseDados := not FileExists(LCaminhoBaseDados, true);

  If LCriarBaseDados then
  begin
    CriarTabelas();
    InserirDados();
  end;
end;

procedure TdmRavin.cnxBancoDeDadosBeforeConnect(Sender: TObject);
var
  LCaminhoBaseDados: String;
  LCriarBaseDados: Boolean;
begin
  LCaminhoBaseDados := 'C:\ProgramData\MySQL' +
    '\MySQL Server 8.0\Data\ravin\pessoa.ibd';
  LCriarBaseDados := not FileExists(LCaminhoBaseDados, true);
  with cnxBancoDeDados do
  begin
    Params.Values['Server'] := 'localhost';
    Params.Values['User_Name'] := 'root';
    Params.Values['Password'] := 'root';
    Params.Values['DriverID'] := 'MySQL';
    Params.Values['Port'] := '3306';

    if not LCriarBaseDados then
    begin
      Params.Values['Database'] := 'ravin';
    end;
  end;
end;

procedure TdmRavin.CriarTabelas;
begin
  try
    cnxBancoDeDados.ExecSQL(TResourceUtils
    .carregarArquivoResource
      ('createTable.sql', 'ravin'));
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;
procedure TdmRavin.InserirDados;
begin
  try
    cnxBancoDeDados.StartTransaction();
    cnxBancoDeDados.ExecSQL(TResourceUtils
    .carregarArquivoResource
      ('inserts.sql', 'ravin'));
    cnxBancoDeDados.Commit();
  except
    on E: Exception do
    begin
      cnxBancoDeDados.Rollback();
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TdmRavin.DataModuleCreate(Sender: TObject);
begin
  if not cnxBancoDeDados.Connected then
  begin
    cnxBancoDeDados.Connected := true;
  end;
end;

end.
