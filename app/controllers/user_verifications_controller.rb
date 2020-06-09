class UserVerificationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.verified && user.verified?(params[:token])
      user.verify
      log_in user
      redirect_to home_path, success: 'Conta verificada com sucesso'         
    else
      redirect_to root_path, error: 'Link de verificação inválido' 
    end
  end
end
