class InterviewsController < ApplicationController
  def show
    @interview = Interview.find(params[:id])
    @evaluations = Evaluation.where(interview_id: @interview.id).where.not(desLevel: 0)
    @evaluations.each do |ev|

      @evaluation_user = EvaluationsUser.new(evaluation_id: ev.id, user_id: current_user.id, responsible: false, temporal_level: 1)

      if @evaluation_user.save!
        ActionCable.server.broadcast 'interviews',
          evaluation: @evaluation_user.evaluation_id,
          evaluation_user: @evaluation_user.user_id,
          evaluation_responsible: @evaluation_user.responsible,
          evaluation_level: @evaluation_user.temporal_level
      end

    end
  end


  def update_responsible
    @evaluation = Evaluation.find(params[:ev_id])
    @evaluation_user = EvaluationUser.where(evaluation_id: @evaluation.id, user_id: params[:user_id])
    @new_role = params[:role]
    @evaluation_user.responsible = @new_role
  end

  def update_level
    @evaluation = Evaluation.find(params[:ev_id])
    @evaluation_user = EvaluationUser.where(evaluation_id: @evaluation.id, user_id: params[:user_id])
    @new_level = Level.find(params[:level_id])
    @evaluation_user.temporal_level = @new_level.id
  end

end
