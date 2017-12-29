class SemestersController < ApplicationController
  def index
    @semesters = Semester.all
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
