class SessionsController < ApplicationController
  layout "login"
  before_action :require_logout, only: [:new, :create]
  before_action :require_login, only: [:leave, :destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) && user.active
      if user.verified
        log_in user
        remember user if params[:session][:remember_me] == "1"
        redirect_back_or home_path
      else
        flash[:warning] = "Conta não verificada. Por favor, consulte seu email para obter o link de verificação!"
        redirect_to root_path
      end
    else
      flash.now[:error] = "Usuário/Senha inválidos!"
      render "new"
    end
  end

  def leave
  end

  def destroy
    log_out
    redirect_to login_path, success: "Deslogado com sucesso!"
  end
end
