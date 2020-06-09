class HomeController < ApplicationController
  before_action :require_login

  def index
    if current_user.admin?
      @essays = Essay.all
      
      @corrections = Correction.includes(essay: :theme, student: :user).limit(5)

      @correcting = @corrections.where.not(start_date: nil).where(end_date: nil).order(start_date: 'desc')
      @corrected = @corrections.where.not(start_date: nil).where.not(end_date: nil).order(end_date: 'desc')


      @students = Student.includes(:user, :category).where(users: {active: true})
      @enem = @students.where(category_id: 2)
      @ifrn = @students.where(category_id: 1)
      render 'admins/home'

    elsif current_user.reviewer?
      render 'reviewers/home'

    elsif current_user.student?
      render 'students/home'
    end
  end
end
