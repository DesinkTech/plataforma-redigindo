class CreditsController < ApplicationController
  before_action :require_admin
  before_action :set_student

  def edit
  end

  def update
    @student.refill_credits(student_params[:credits].to_i)

    if @student.save
      redirect_to students_path, success: "Creditos abastecidos com sucesso"
    else
      render :edit
    end
  end

  private
  
  def student_params
    params.require(:student).permit(:credits)
  end

  def set_student
    @student = Student.find_by(id: params[:user_id])
  end
end
