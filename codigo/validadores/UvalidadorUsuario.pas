unit UvalidadorUsuario;

interface

uses
  System.SysUtils,
  Uusuario;

type
  TValidadorUsuario = class
  private

  protected

  public
    class procedure Validar(PUsuario: TUsuario; PSenhaConfirmacao: String;
      PCpf: String);
  end;

implementation

{ TValidadorUsuario }

uses UvalidaCpf;

class procedure TValidadorUsuario.Validar(PUsuario: TUsuario;
  PSenhaConfirmacao: String; PCpf: String);
begin

  // Nome n�o pode ser vazio
  // Login n�o pode ser vazio
  // CPF � vazio
  // Quantidade de caracteres do login
  // S� numeros no CPF
  // Nome n�o pode aceitar numero
  // Validar caracteres especiais nos campos
  // CPF n�o pode ser vazio
  // Senha = Confirma��o Senha
  // CPF � valido

  if not isCPF(PCpf) then
  begin
    raise Exception.Create('CPF inv�lido');
  end;

  if PUsuario.login.IsEmpty then
  begin
    raise Exception.Create('O campo login n�o pode ser vazio');
  end;

  if PUsuario.senha.IsEmpty then
  begin
    raise Exception.Create('O campo senha n�o pode ser vazio');
  end;

  if PUsuario.senha <> PSenhaConfirmacao then
  begin
    raise Exception.Create('A senha e a confirma��o ' + 'devem ser iguais');
  end;
end;

end.
