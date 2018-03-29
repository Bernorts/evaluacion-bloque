class InterviewsController < ApplicationController
  def show
    @interview = Interview.find(params[:id])
    @evaluations = Evaluation.where(interview_id: @interview.id)

  end

  def create
    @interview = Interview.find(params[:interview_id])
    @evaluations = Evaluation.where(interview_id: @interview.id)
    @evaluations.each do |ev|
      @evaluation_user = new EvaluationUser(ev.id, current_user, false, 1)
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
