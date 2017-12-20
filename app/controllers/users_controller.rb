class UsersController < ApplicationController
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
    if @user.update(password_params)
      flash[:success] = "Usuario creado correctamente"
      redirect_to show_user_path(@user)
    else
      render 'edit'
    end
  end

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :role_id)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
