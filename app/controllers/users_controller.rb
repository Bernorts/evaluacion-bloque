class UsersController < ApplicationController
  before_action :logged_in_user, only: [:new, :index, :editUser, :update]
  before_action :correct_user,   only: [:edit]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def create
    @user = User.new(user_params)
    @user.password = 'semestrei'
    @user.password_confirmation = 'semestrei'
    if @user.save
      flash[:success] = "Usuario creado correctamente"
      redirect_to show_user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def editUser
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save(context: :password)
      flash[:success] = "Contraseña modificada correctamente"
      redirect_to show_user_path(@user)
    else
      render 'edit'
    end
  end

  def update_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Usuario modificado correctamente"
      redirect_to show_user_path(@user)
    else
      render 'editUser'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario eliminado exitosamente"
    redirect_to users_url
  end

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :role_id)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Por favor inicia sesión"
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(login_url) unless @user == current_user
  end


end
