# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[new index editUser update]
  before_action :correct_user,   only: [:edit]
  before_action :authorize_profile, only: %i[show update_user destroy]
  before_action :authorize_index, only: [:index]

  def index
    # this should change with the semester dropdown
    @professors = Semester.find(session[:semester]).users.where('role_id = ? OR role_id = ?', 1, 2)
    @students = Semester.find(session[:semester]).users.where(role_id: 3)
  end

  def show
    @user = User.find(params[:id])
    @user_evaluations = Evaluation.where(user_id: @user.id)
    @interviews = []
    @inter_evaluations = Evaluation.where(user_id: @user.id).select('DISTINCT ON (interview_id) *')
    @interviews_ids = @inter_evaluations.map(&:interview_id).reverse
    @interviews_ids.each do |id|
      @interviews.push(Interview.find(id)) unless id.nil?
    end
    @evidence = Evidence.new
    @evidences = @user.evidences
    @evaluation = Evaluation.new
    @competences = Competence.all
    @levels = Level.all
    puts 'Current Semester' + current_semester.id.to_s
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def create
    @user = User.new(user_params)
    @user.password = 'semestrei'
    @user.password_confirmation = 'semestrei'
    @user.semesters << current_semester
    @competences = Competence.all

    if @user.save
      @competences.each do |competence|
        @evaluation = Evaluation.new(achLevel: 1, competence_id: competence.id, user_id: @user.id)
        @evaluation.save
      end
      flash[:success] = 'Usuario creado correctamente'
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
      flash[:success] = 'Contraseña modificada correctamente'
      redirect_to show_user_path(@user)
    else
      render 'edit'
    end
  end

  def personal_grades
    @student = current_user
    @competences = Competence.select(:id, :name)
    @header = []
    @header.push('Matrícula')
    @header.push('Nombre')
    @count_competences = Competence.all.count
    @competences.each do |c|
      @header.push(c.name)
    end
    @evaluations_user = {}
    @temp_evals = Evaluation.where(user_id: @student.id).where.not(achLevel: nil)
    @last_competences_level = []
    if @temp_evals.empty?
      i = 0
      until i == @count_competences
        @last_competences_level.push('No se han registrado evaluaciones')
        i += 1
      end
    else
      @competences.each do |c|
        @last_record = @temp_evals.where(competence_id: c.id).last
        if @last_record.nil?
          @last_competences_level.push('No se ha registrado evaluación')
        else
          temp_level = Level.find(@last_record.achLevel)
          @last_competences_level.push(temp_level.name)
        end
      end
      @last_competences_level.unshift(@student.name)
      matricula = @student.email.split('@')[0]
      @last_competences_level.unshift(matricula)
      @evaluations_user[@student.id] = @last_competences_level
    end
    respond_to do |format|
      format.html
      name = @student.name
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment;' + 'filename=' + "#{name}.xlsx"
      end
    end
  end

  def update_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Usuario modificado correctamente'
      redirect_to show_user_path(@user)
    else
      render 'editUser'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'Usuario eliminado exitosamente'
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
      flash[:error] = 'Por favor inicia sesión'
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:error] = 'Acceso no autorizado'
      redirect_to(login_url)
    end
  end

  def authorize_profile
    @user = User.find(params[:id])
    if @user != current_user
      if current_user.role_id != 1 && current_user.role_id != 2
        flash[:error] = 'Acceso no autorizado'
        redirect_to show_user_url(current_user)
      end
    end
  end

  def authorize_index
    if current_user.role_id != 1 && current_user.role_id != 2
      flash[:error] = 'Acceso no autorizado'
      redirect_to show_user_url(current_user)
    end
  end
end
