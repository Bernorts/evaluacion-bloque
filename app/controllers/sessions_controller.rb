class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      set_semester (current_user.semesters.last.id)
      if user.role_id == 3
        redirect_to show_user_url(user)
      else
        redirect_to all_semester_users_url
      end
    else
      flash.now[:error] = 'Correo o contraseña inválidos'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_url
  end
end
