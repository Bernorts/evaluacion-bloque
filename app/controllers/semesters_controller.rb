class SemestersController < ApplicationController
  def index
    @semesters = Semester.all
  end
  def show
    @semester = Semester.find(params[:id])
    @users = @semester.users
    @users_evaluations = []
    @competences = Competence.all
    @users_arr = []
    @users.each do |user|
      @users_arr.push(user.id)
    end
    @users_evaluations = Evaluation.where(user_id: @users_arr).where("created_at >= ?", @semester.start_date)
    puts @users_evaluations.inspect
  end

  def new
    @semester = Semester.new
    @users = User.all
  end


  def create
    @semester = Semester.new(semester_params)
    @users = params[:semester][:user_ids]
    @users = @users.delete_if { |x| x.empty? }
    if @semester.save
      flash[:success] = "Semestre creado correctamente"
      redirect_to semesters_path
    else

      render 'new'
    end
  end

  def grades
    @semester = Semester.find(params[:id])
    @students = @semester.users.where(role_id: 1).order(:email)
    @competences = Competence.select(:id, :name)
    @header = []
    @header.push('Matrícula')
    @header.push('Nombre')
    @count_competences = Competence.all.count
    @competences.each do |c|
      @header.push(c.name)
    end
    @evaluations_user  = {}
    @students.each do |student|
      @temp_evals = Evaluation.where(user_id: student.id)
      @last_competences_level = []
      if (@temp_evals.empty?)
        i = 0
        until i == @count_competences
          @last_competences_level.push("No se han registrado evaluaciones")
          i += 1
        end
      else
        @competences.each do |c|
          @last_record = @temp_evals.where(competence_id: c.id).last
          if @last_record.achLevel.nil?
            prev_to_last = @temp_evals.where(competence_id: c.id)[-2]
            if prev_to_last.nil?
              @last_competences_level.push("Primera evaluacion pendiente")
            else
              temp_level = Level.find(prev_to_last.achLevel)
              @last_competences_level.push(temp_level.name)
            end

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
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment;" +  "filename=" + "#{name}.xlsx"
      }
    end
  end

  def edit
    @semester = Semester.find(params[:id])
  end

  def update
    @semester = Semester.find(params[:id])
    @users = params[:semester][:user_ids]
    @users = @users.delete_if { |x| x.empty? }
    if @semester.update_attributes(semester_params)
      flash[:success] = "Semestre editado correctamente"
      redirect_to semesters_path
    else
      render 'edit'
    end
  end

  def destroy
    @semester = Semester.find(params[:id])
    #delete every evidence created during the semester of the users signed up for it
    for u in @semester.users do
      u.evidences.where(:created_at => @semester.start_date.beginning_of_day..@semester.end_date.end_of_day).destroy_all
    end
    @semester.destroy
    flash[:success] = "Semestre eliminado exitosamente"
    redirect_to semesters_url
  end


  def semester_params
    params.require(:semester).permit(:name, :start_date, :end_date, user_ids: [])
  end

end
