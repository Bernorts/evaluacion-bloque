class InterviewsController < ApplicationController
  def show
    @interview = Interview.find(params[:id])
    @evaluations = Evaluation.where(interview_id: @interview.id).where.not(desLevel: 0)
    @levels = Level.all
    @all_levels = {}
    @current_int = params[:id]
      @levels.each do |l|
        @all_levels.merge!({l.id => l.name})
      end

    @evaluations.each do |ev|
      @evaluation_user = EvaluationsUser.new(evaluation_id: ev.id, user_id: current_user.id, responsible: false, temporal_level: 1)
      @user = User.find(@evaluation_user.user_id)
      @user_name = @user.name.to_s + ' ' +  @user.last_name.to_s
      @level = Level.find(@evaluation_user.temporal_level)
      @competence_id = ev.competence_id


      @aux_responsible = ''
      if @evaluation_user.responsible == false
        @aux_responsible = 'Evaluador'
      else
        @aux_responsible = 'Responsable'
      end

      if (!EvaluationsUser.find_by(evaluation_id: ev.id, user_id: @user.id) && @evaluation_user.save!)
        ActionCable.server.broadcast 'interviews',
          evaluation: @evaluation_user.evaluation_id,
          evaluation_user: @user_name,
          evaluation_responsible: @aux_responsible,
          evaluation_level: @level.name,
          evaluation_competence_id: @competence_id,
          all_levels: @all_levels.to_json()
      end
    end

    @evaluators_ids = EvaluationsUser.where(evaluation_id: @evaluations[0])
    @inter_evaluators = []

    @evaluators_ids.each do |evals|
      @inter_evaluators.push(User.find(evals.user_id))
    end

  end

  def update
  end

  def update_responsible
    puts "entering update responsible"
    puts params
    @evaluation = Evaluation.find(params[:evaluation])
    @evaluation_user = EvaluationsUser.where(evaluation_id: @evaluation.id, user_id: params[:professor_id]).first
    @new_role = params[:role]
    @evaluation_user.responsible = @new_role
    puts @evaluation_user.inspect
    puts @evaluation_user.errors.inspect
    @evaluation_user.save


    @evaluation_user.update(responsible: @new_role)
  end

  def update_level

    puts params
    @evaluation = Evaluation.find(params[:ev_id])
    @evaluation_user = EvaluationUser.where(evaluation_id: @evaluation.id, user_id: params[:user_id])
    @new_level = Level.find(params[:level_id])
    @evaluation_user.temporal_level = @new_level.id
  end

  def update_retro
    puts params
  end

  def final_evaluation
    puts params
  end

end
