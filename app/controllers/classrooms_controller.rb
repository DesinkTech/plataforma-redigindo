class ClassroomsController < ApplicationController
  before_action :require_login, :require_admin
  before_action :set_classroom, execept: [:index, :new, :create]
  before_action :address_options, only: [:new, :create, :edit, :update]

  def index
    @classrooms = Classroom.paginate(page: params[:page], per_page: 16)
  end

  def show
    @students = Student.includes(:category, :school, :classroom, user: :address).paginate(page: params[:page], per_page: 16)
      .where(users: { verified: true })
      .where(classroom_id: @classroom.id)
      .order(registration_number: "asc")
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

  def new_file
    if not classroom_params[:files].nil?
      if @classroom.files.attach(classroom_params[:files])
        redirect_to classroom_path(@classroom), success: "Arquivo anexado com sucesso!"
      end
    else
      redirect_to classroom_path(@classroom), error: "Não há arquivo anexado ou contém formato inválido!"
    end
  end

  def purge_file
    @file = @classroom.files.find_by(id: params[:file_id])

    @file.purge
    redirect_to classroom_path(@classroom), success: "Arquivo excluído com sucesso!"
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
    params.fetch(:classroom, {}).permit(:name, :address_id, :files)
  end

  def set_classroom
    @classroom = Classroom.find_by(id: params[:id])
  end

  def address_options
    @address_options = Address.all.pluck(:city, :id)
  end
end
