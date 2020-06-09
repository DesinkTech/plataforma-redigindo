class SubmissionsController < ApplicationController
  before_action :require_login, :require_student
  
  def index
    @essays = Essay.includes(:student, :theme, :category)
      .where(student_id: current_user.student.id)
      .where(active: true)
      .order(submission_date: 'desc')

    @essays_count = @essays.count
    @essays = @essays.limit(25)

    corrections = Correction.includes(:essay, :student, :reviewer, :admin)
      .where(student_id: current_user.student.id)

    
    @correcting = corrections.where(end_date: nil).where.not(start_date: nil).order(end_date: 'desc')
    @correcting_count = @correcting.count
    @correcting = @correcting.limit(25)

    @corrected = corrections.where.not(start_date: nil, end_date: nil).order(end_date: 'desc')
    @corrected_count = @corrected.count
    @corrected = @corrected.paginate(page: params[:page], per_page: 25)
  end

  private

end
