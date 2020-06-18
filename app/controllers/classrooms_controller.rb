class ClassroomsController < ApplicationController
  before_action :require_login, :require_admin
  before_action :set_classroom, execept: [:index, :new, :create]
  before_action :address_options, only: [:new, :create, :edit, :update]

  def index
    @classrooms = Classroom.paginate(page: params[:page], per_page: 16)
  end

  def show
    @students = Student.includes(:category, :school, :classroom, user: :address).paginate(page: params[:page], per_page: 25)
      .where(users: { verified: true })
      .where(classroom_id: @classroom.id)
      .order(registration_number: 'asc')
  end

  def new
    @classroom = Classroom.new
  end

  def create
    @classroom = Classroom.new(classroom_params)

    if @classroom.save
      redirect_to classrooms_path, success: "Turma criada com sucesso!"
    else
      render[:new]
    end
  end

  def edit
  end

  def update
    if @classroom.update(classroom_params)
      redirect_to classrooms_path, success: "Turma atualizada com sucesso!"
    else
      render[:edit]
    end
  end

  private

  def classroom_params
    params.require(:classroom).permit(:name, :address_id)
  end

  def set_classroom
    @classroom = Classroom.find_by(id: params[:id])
  end

  def address_options
    @address_options = Address.all.pluck(:city, :id)
  end
end
