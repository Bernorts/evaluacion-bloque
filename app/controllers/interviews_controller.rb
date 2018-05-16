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

  def update_responsible
    @evaluation = Evaluation.find(params[:evaluation])
    @evaluation_user = EvaluationsUser.find_by(evaluation_id: @evaluation.id, user_id: params[:professor_id])
    @new_role = params[:role]
    @evaluation_user.responsible = @new_role
    @evaluation_user.save
    @evaluation_user.update(responsible: @new_role)
  end

  def update_level
    @evaluation = Evaluation.find(params[:evaluation])
    @evaluation_user = EvaluationsUser.find_by(evaluation_id: @evaluation.id, user_id: params[:professor_id])
    @new_level = Level.find(params[:level_id])
    @evaluation_user.temporal_level = @new_level.id
    @evaluation_user.save
=begin
    if (@evaluation_user.save)
      ActionCable.server.broadcast 'interviews',
        evaluation: @evaluation,
        evaluation_user: @evaluation_user,
        evaluation_leve: @new_level
    end
=end
  end

  def update_retro
    @evaluation = Evaluation.find(params[:evaluation])
    @retro = params[:retro]
    @evaluation.retro = @retro
    @evaluation.save
=begin
    if (@evaluation.save)
      ActionCable.server.broadcast 'interviews',
        evaluation: @evaluation
    end
=end
  end

  def final_evaluation
    @evaluation = Evaluation.find(params[:evaluation])
    @level  = Level.find(params[:final_level])
    @evaluation.achLevel = @level.id
    @evaluation.eval_date = DateTime.parse(Date.today.to_s)
    @evaluation.save
=begin
    if (@evaluation.save)
      ActionCable.server.broadcast 'interviews',
        evaluation: @evaluation
    end
=end
  end

end
