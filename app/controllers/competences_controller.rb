class CompetencesController < ApplicationController
  
  def semester_competences
    @semester = Semester.find(params[:id])

  end
end
