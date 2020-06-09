class AdminsController < ApplicationController
  before_action :require_login
  before_action :require_admin
  before_action :address_options, only: [:new, :create, :edit, :update]
  before_action :set_admin, only: [:show, :edit, :update]

  def new
    @admin = Admin.new
    @admin.build_user
  end

  def create
    @admin = Admin.new(admin_params)
    @admin.user.role_id = 1

    if @admin.save
        @admin.user.send_verification_email
        redirect_to home_path, info: "Conta administrador criada com sucesso, email de verificação enviado para conta de email cadastrado" 
    else
        render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @admin.update(admin_params)
        redirect_to edit_admin_path(current_user.username.delete(' ').downcase), success: "Perfil atualizado com sucesso"
    else
        flash.now[:error] = "Erro ao atualizar perfil"
        render :edit
    end
  end

  private

  def set_admin
    @admin = current_user.admin
  end

  def admin_params
    params.require(:admin).permit(user_attributes: [:id, :email, :username, :password, :password_confirmation, :name, :birth_date, :cpf, :rg, :address_id])
  end

  def address_options
    @address_options = Address.all.pluck(:city, :id)
  end
end
