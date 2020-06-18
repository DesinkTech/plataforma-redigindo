class SchoolsController < ApplicationController
  before_action :require_login, :require_admin
  before_action :set_school, only: [:edit, :update, :destroy]

  def index
    @schools = School.paginate(page: params[:page], per_page: 16)
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)

    if @school.save
      redirect_to schools_path, success: "Escola inserida com sucesso"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @school.update(school_params)
      redirect_to schools_path, success: "Escola alterada com sucesso"
    else
      render :edit
    end
  end

  def destroy
    @school.destroy  
  end

  private
  
  def school_params
    params.require(:school).permit(:name)
  end
  
  def set_school
    @school = School.find_by(id: params[:id])
  end

end
