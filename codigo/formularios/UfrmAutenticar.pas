unit UfrmAutenticar;

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
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls,

  UfrmBotaoPrimario,
  UfrmBotaoSecundario;

type
  TfrmAutenticar = class(TForm)
    imgFundo: TImage;
    pnlAutenticacao: TPanel;
    lblTitulo: TLabel;
    lblSubTitulo: TLabel;
    edtLogin: TEdit;
    edtSenha: TEdit;
    frmBotaoPrimarioAutenticar: TfrmBotaoPrimario;
    ImageLogo: TImage;
    lblTituloRegistrar: TLabel;
    lblSubTituloRegistras: TLabel;
    procedure frmBotaoPrimarioAutenticarspbBotaoPrimarioClick(Sender: TObject);
    procedure lblSubTituloRegistrasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure Autenticar();
  public
    { Public declarations }
  end;

var
  frmAutenticar: TfrmAutenticar;

implementation

{$R *.dfm}

uses
  UfrmPainelGestao,
  Uusuario,
  UusuarioDao,
  UfrmRegistrar,
  UiniUtils,
  UformUtils;

{ TfrmLogin }

procedure TfrmAutenticar.Autenticar;
var
  LUsuarioDAO: TUsuarioDAO;
  LUsuario: TUsuario;
  LLogin: String;
  LSenha: String;
begin

  // Limpa poss�veis sujeiras das vari�veis locais
  LUsuario := nil;
  LUsuarioDAO := nil;

  // Pega os valores dos edits de login
  LLogin := edtLogin.Text;
  LSenha := edtSenha.Text;

  try
    try
      // Caso os valores de login e senha n�o sejam vazios ser� feita a tentitiva de
      // autentica��o
      if (not LLogin.IsEmpty) and (not LSenha.IsEmpty) then
      begin
        // Tenta carregar um usu�rio com o login e senha informados
        LUsuarioDAO := TUsuarioDAO.Create();
        LUsuario := LUsuarioDAO.BuscarUsuarioPorLoginSenha(LLogin, LSenha);

        // Caso exista quer o usu�rio � levado a tela de login
        if Assigned(LUsuario) then
        begin

          // Registrando a data do ultimo login do usu�rio
          TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS,
            TPROPRIEDADE.DATAHORA_ULTIMO_LOGIN, DateTimeToStr(Now));

          // Registrar que o usu�rio efetuou o login com sucesso
          TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS,
            TPROPRIEDADE.LOGADO, TIniUtils.VALOR_VERDADEIRO);

          TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS,
            TPROPRIEDADE.LOGIN_ATUAL, LLogin);

          // Mostrando o forma de Painel de Gest�o
          TFormUtils.MostrarFormulario<TfrmPainelGestao>(frmPainelGestao, Self);
        end
        else
        begin
          ShowMessage('Login e/ou senha inv�lido');
        end;
      end
      else
      begin
        ShowMessage('Login e senha s�o obrigat�rios');
      end;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    if Assigned(LUsuario) then
      FreeAndNil(LUsuario);
    if Assigned(LUsuarioDAO) then
      FreeAndNil(LUsuarioDAO);
  end;
end;

procedure TfrmAutenticar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmAutenticar := nil;
end;

procedure TfrmAutenticar.frmBotaoPrimarioAutenticarspbBotaoPrimarioClick
  (Sender: TObject);
begin
  Autenticar();
end;

procedure TfrmAutenticar.lblSubTituloRegistrasClick(Sender: TObject);
begin
  TFormUtils.MostrarFormulario<TfrmRegistrar>(frmRegistrar, Self);
end;

end.
