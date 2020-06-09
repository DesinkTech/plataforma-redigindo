class UserMailer < ApplicationMailer
  default from: "no-reply@redigindo.com.br"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_verification.subject
  #
  def account_verification(user)
    @user = user

    mail to: user.email, subject: "Verificação de conta"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user

    mail to: user.email, subject: "Redifinição de senha"
  end
end
