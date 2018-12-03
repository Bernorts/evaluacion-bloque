class CompetencesController < ApplicationController
  before_action :set_semester, only: %w[semester_competences save_competences edit]
  before_action :authorize, only: [:edit]

  def semester_competences
    @levels = @semester.competences.first.levels.sort_by &:order
  end

  def edit
    @levels = @semester.competences.first.levels.sort_by &:order
  end

  def authorize
    if current_user.role_id != 1
      flash[:error] = "Acceso no autorizado"
      redirect_to show_user_url(current_user)
    end
  end

  def save_competences
    addedLevels = []
    addedComps = []

    # edit existing levels
    unless params[:levels_names].nil?
      params[:levels_names].each do |k, v|
        l = Level.find(k.to_i)
        l.name = v
        l.save
      end
    end

    # create new levels
    unless params[:new_levels_names].nil?
      params[:new_levels_names].each do |_, l|
        unless l.empty?
          n = Level.create(name: l)
          addedLevels.append n
        end
      end
    end

    # edit existing competences
    @semester.competences.delete_all # this doesn't delete the competence from db, only sets semester_id to null
    unless params[:competences_names].nil?
      params[:competences_names].each do |k, v|
        evidence = params[:competences_evidences][k]
        if !evidence.nil?
          @competence_evidences = params[:competences_evidences][k]
        end

        unless v.empty?
          c = Competence.find(k.to_i)
          c.evidences = @competence_evidences
          c.name = v
          unless params[:competences_descriptions][k].empty?
            c.description = params[:competences_descriptions][k]
          end
          c.save
          @semester.competences.append c
          c.levels.delete_all
          unless params[:levels_names].nil?
            params[:levels_names].each do |k, v|
              c.levels.append Level.find(k.to_i)
            end
          end
          unless params[:new_levels_names].nil?
            params[:new_levels_names].each do |_, v|
              c.levels.append Level.where(name: v)
            end
          end
        end
      end
    end

    # create new competences
    unless params[:new_competences_names].nil?
      params[:new_competences_names].each do |k, v|
        evidence = params[:new_competences_evidences][k]
        if !evidence.nil?
          @competence_evidences = params[:new_competences_evidences][k]
        end
        unless v.empty?
          c = Competence.new(name: v)
          c.evidences = @competence_evidences
          unless params[:new_competences_descriptions][k].empty?
            c.description = params[:new_competences_descriptions][k]
          end
          c.save
          addedComps.append c
          @semester.competences.append c
          c.levels.delete_all
          unless params[:levels_names].nil?
            params[:levels_names].each do |k, v|
              c.levels.append Level.find(k.to_i)
            end
          end
          unless params[:new_levels_names].nil?
            params[:new_levels_names].each do |_, v|
              c.levels.append Level.where(name: v)
            end
          end
        end
      end
    end

    # edit existing competence_level
    unless params[:competence_levels].nil?
      params[:competence_levels].each do |k, v|
        unless v.empty?
          comp = k.split(',')[0]
          lev = k.split(',')[1]
          c = CompetenceLevel.where(competence_id: comp.to_i, level_id: lev.to_i).first
          c.description = v
          c.save
        end
      end
    end

    # add description to competence_level for each created level (column appended)
    unless addedLevels.empty?  || params[:new_levels_competences].nil?
      params[:new_levels_competences].each do |k, v|
        unless v.empty?
          lev = k.split(',')[0]
          comp = k.split(',')[1]
          c = CompetenceLevel.where(competence_id: @semester.competences[comp.to_i - 1].id, level_id: addedLevels[lev.to_i].id)
          unless c.empty?
            c = c.first
            c.description = v
            c.save
          end
        end
      end
    end

    # add description to competence_level for each created competence (row appended)
    unless addedComps.empty? || params[:new_competences_levels].nil?
      params[:new_competences_levels].each do |k, v|
        unless v.empty?
          comp = k.split(',')[0]
          lev = k.split(',')[1]
          c = CompetenceLevel.where(competence_id: addedComps[comp.to_i].id, level_id: @semester.competences.first.levels[lev.to_i - 2].id)
          unless c.empty?
            c = c.first
            c.description = v
            c.save
          end
        end
      end
    end

    Competence.where(semester_id: nil).delete_all
    redirect_to semester_competences_url(@semester)
  end

  def set_semester
    @semester = Semester.find(params[:id])
  end
end
