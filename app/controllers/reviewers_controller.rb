class ReviewersController < ApplicationController
  before_action :require_logout, only: [:new, :create]
  before_action :require_login, except: [:new, :create]
  before_action :require_admin, only: [:index, :activate, :destroy]
  before_action :require_reviewer, only: [:edit, :update, :deactivate]
  before_action :address_options, only: [:new, :create, :edit, :update]
  before_action :set_reviewer, only: [:show, :edit, :update, :activate, :deactivate, :destroy]


  def index
    @reviewers = Reviewer.includes(user: :address).paginate(page: params[:page], per_page: 25)
      .joins(:user)
      .where(users: { verified: true })
  end
  
  def show
  end

  def new
    @reviewer = Reviewer.new
    @reviewer.build_user
  end

  def create
    @reviewer = Reviewer.new(reviewer_params)
    @reviewer.user.role_id = 2

    if @reviewer.save
      @reviewer.user.send_verification_email
      redirect_to root_path, info: "Consulte seu email para verificar sua conta"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @reviewer.update(reviewer_params)
      redirect_to student_path(current_user.name.delete(' ')), success: "Perfil atualizado com sucesso"
    else
      flash.now[:error] = "Erro ao atualizar perfil"
      render :edit
    end
  end

  def activate
    unless @reviewer.user.active?
      @reviewer.user.toggle(:active)
      redirect_to home_path, error: "Erro ao ativar usuário" unless @reviewer.save
      redirect_to reviewers_path
    end
  end

  def deactivate
    if @student.user.active?
      @student.user.toggle(:active)
      redirect_to home_path, error: "Erro ao desativar usuário" unless @student.save
      redirect_to students_path
    end
  end

  def destroy
    @reviewer.destroy
    redirect_to reviewers_path, success: 'Corretor removido com sucesso'
  end

  private

  def set_reviewer
    @reviewer = current_user.reviewer || Reviewer.find_by(id: params[:id]) 
  end

  def reviewer_params
    params.require(:reviewer).permit(user_attributes: [:id, :email, :password, :password_confirmation, :name, :birth_date, :cpf, :rg, :address_id])
  end

  def address_options
    @address_options = Address.all.pluck(:city, :id)
  end
end
