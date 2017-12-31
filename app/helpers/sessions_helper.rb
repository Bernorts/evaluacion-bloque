module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def set_semester(semester)
    session[:semester] = semester
  end

  def set_semester_url
    session[:semester] = params[:id]
    redirect_to :back
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_semester
    @current_semester ||= Semester.find_by(id: session[:semester])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
