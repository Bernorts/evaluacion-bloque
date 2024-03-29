# frozen_string_literal: true

class SemestersController < ApplicationController
  before_action :authorize

  def index
    @semesters = Semester.all
  end

  def show
    @semester = Semester.find(params[:id])
    @users = @semester.users
    @teachers = @semester.users.where(role_id: 2)
    @students = @semester.users.where(role_id: 3)
    @users_evaluations = []
    @competences = Competence.all
    @users_arr = []
    @users.each do |user|
      @users_arr.push(user.id)
    end
    @users_evaluations = Evaluation.where(user_id: @users_arr).where('created_at >= ?', @semester.start_date)
    puts @users_evaluations.inspect
  end

  def new
    @semester = Semester.new
    @users = User.where(role_id: 3)
    @new_users = []
    @old_users = []
    @professors = User.where.not(role_id: 3)
    @users.each do |user|
      if user.semesters.empty?
        @new_users.push(user)
      else
        @old_users.push(user)
      end
    end
  end

  def create
    @last_competences = Semester.last.competences
    @semester = Semester.new(semester_params)
    @semester.competences = @last_competences
    @users = params[:semester][:user_ids]
    @users = @users.delete_if(&:empty?)
    if @semester.save
      flash[:success] = 'Semestre creado correctamente'
      redirect_to semesters_path
    else

      render 'new'
    end
  end

  def grades
    @semester = Semester.find(params[:id])
    @students = @semester.users.where(role_id: 3).order(:email)
    @competences = Competence.select(:id, :name)
    @header = []
    @header.push('Matrícula')
    @header.push('Nombre')
    @count_competences = Competence.all.count
    @competences.each do |c|
      @header.push(c.name)
    end
    @evaluations_user = {}
    @students.each do |student|
      @temp_evals = Evaluation.where(user_id: student.id).where.not(achLevel: nil, desLevel: 0)
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
      end
      @last_competences_level.unshift(student.name)
      matricula = student.email.split('@')[0]
      @last_competences_level.unshift(matricula)
      @evaluations_user.merge!(student.id => @last_competences_level)
    end
    respond_to do |format|
      format.html
      name = @semester.name
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment;' + 'filename=' + "#{name}.xlsx"
      end
    end
  end

  def edit
    @semester = Semester.find(params[:id])
    @users = User.where(role_id: 3)
    @new_users = []
    @old_users = []
    @professors = User.where.not(role_id: 3)
    @users.each do |user|
      if user.semesters.empty?
        @new_users.push(user)
      else
        @old_users.push(user)
      end
    end
  end

  def update
    @semester = Semester.find(params[:id])
    @users = params[:semester][:user_ids]
    @users = @users.delete_if(&:empty?)
    if @semester.update_attributes(semester_params)
      flash[:success] = 'Semestre editado correctamente'
      redirect_to semesters_path
    else
      render 'edit'
    end
  end

  def destroy
    @semester = Semester.find(params[:id])
    # delete every evidence created during the semester of the users signed up for it
    @semester.users.each do |u|
      u.evidences.where(created_at: @semester.start_date.beginning_of_day..@semester.end_date.end_of_day).destroy_all
    end
    @semester.destroy
    flash[:success] = 'Semestre eliminado exitosamente'
    redirect_to semesters_url
  end

  def semester_params
    params.require(:semester).permit(:name, :start_date, :end_date, user_ids: [])
  end

  def authorize
    if current_user.role_id != 1 && current_user.role_id != 2
      flash[:error] = 'Acceso no autorizado'
      redirect_to show_user_url(current_user)
    end
  end
end
