class InterviewsController < ApplicationController
  def show
    @interview = Interview.find(params[:id])
    @evaluations = Evaluation.where(interview_id: @interview.id).where.not(desLevel: 0)

    @evaluations.each do |ev|

      @evaluation_user = EvaluationsUser.new(evaluation_id: ev.id, user_id: current_user.id, responsible: false, temporal_level: 1)
      @user = User.find(@evaluation_user.user_id)
      @user = @user.name.to_s + ' ' +  @user.last_name.to_s
      @level = Level.find(@evaluation_user.temporal_level)


      @aux_responsible = ''
      if @evaluation_user.responsible == false
        @aux_responsible = 'Evaluador'
      else
        @aux_responsible = 'Responsable'
      end
      @levels = Level.all
      @all_levels = {}
      @levels.each do |l|
        @all_levels.merge!({l.id => l.name})
      end
      if @evaluation_user.save!
        ActionCable.server.broadcast 'interviews',
          evaluation: @evaluation_user.evaluation_id,
          evaluation_user: @user,
          evaluation_responsible: @aux_responsible,
          evaluation_level: @level.name,
          all_levels: @all_levels.to_json()
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
