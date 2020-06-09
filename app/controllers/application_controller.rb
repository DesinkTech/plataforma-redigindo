class ApplicationController < ActionController::Base
  helper_method :current_user, :get_student_finished_corrections
  add_flash_types :success, :info, :warning, :error

  #==================================================
  #
  # Authentication Helpers
  #
  #==================================================

  # Define the current logged user
  def current_user
    if (user_id = session[:user_id]) 
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.remembered?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Log in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Logs out the current user
  def log_out
    forget(@current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Keeps logged in the user, even if the browser is closed
  def remember(user)
    user.remember
    cookies.signed[:user_id] = { value: user.id, expires: 2.weeks.from_now, httponly: true }
    cookies[:remember_token] = { value: user.remember_token, expires: 2.weeks.from_now, httponly: true }
  end

  # "Forgets" the remembered user
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #==================================================
  #
  # Authorization Helpers
  #
  #==================================================

  # Checks if the logged user tried to access others users spaces
  def invalid_user
    redirect_to home_path, error: "Ação inválida" unless params[:name] == current_user.name.delete(" ")
  end

  # Checks if the user is logged in
  def require_login
    store_location
    redirect_to login_path, warning: "Necessita estar logado" unless current_user
  end

  # Checks if the current user is an Admin
  def require_admin
    redirect_to home_path unless current_user.admin?
  end

  # Checks if the current user is a Reviewer
  def require_reviewer
    redirect_to home_path unless current_user.reviewer?
  end

  # Checks if the current user is a Student
  def require_student
    redirect_to home_path unless current_user.student?
  end

  # Checks if the user is logged out
  def require_logout
    redirect_to home_path if current_user
  end

  # Stores the location intended to the unlogged user
  def store_location
    unless current_user
      session[:fowarding_url] = request.original_url if request.get?
    end
  end

  # Redirects the user to the intended location after log in
  def redirect_back_or(default)
    redirect_to(session[:fowarding_url] || default)
    session.delete(:fowarding_url)
  end
end

#==================================================
#
# Credit Helpers
#
#==================================================

# Checks if the Student have enough credits to send an essay
def require_credits
  redirect_to home_path, warning: "Créditos insuficientes" unless current_user.student.credits > 0
end

#==================================================
#
# Student Helpers
#
#==================================================

def get_student_finished_corrections(limit)
  current_user.student.corrections
  .includes(essay: :theme, admin: :user, reviewer: :user)
  .where.not(end_date: nil)
  .limit(limit)
  .order(end_date: 'desc')
end