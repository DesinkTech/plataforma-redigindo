class PasswordResetsController < ApplicationController
  layout "login"
  before_action :set_user, :check_valid_user, :check_expired_link, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user
      @user.generate_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Instruções para alteração da senha enviados para seu email"
      redirect_to root_path
    else
      flash.now[:error] = "Usuário não encontrado!"
      render :new
    end
  end

  def edit
  end

  def update
    date = @user.reset_at - 2.hours

    if params[:user][:password].empty? || params[:user][:password_confirmation].empty?
      @user.errors.add(:password, "não pode estar vazio")
      @user.errors.add(:password_confirmation, "não pode estar vazio")
      render :edit
    elsif @user.update(user_params) && @user.update(reset_at: date)
      flash[:success] = "Senha alterada com sucesso"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by(email: params[:email])
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def check_valid_user
    unless @user && @user.verified && @user.resetable?(params[:token])
      flash[:error] = "Usuário inválido"
      redirect_to root_path
    end
  end

  def check_expired_link
    if @user.password_reset_expired?
      flash[:warning] = "Link expirado, se ainda deseja resetar sua senha, por favor, solicitar novo link"
      redirect_to root_path
    end
  end
end
