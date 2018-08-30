class EvaluationsController < ApplicationController
	def new
		@competences = Competence.all
		@levels = Level.all
		@evaluation = Evaluation.new
		@evidences = Evidence.where(user_id: current_user.id)
	end

	def evaluate
    evaluation = Evaluation.find(params[:id])
    evaluation.achLevel = params[:achLevel]
		evaluation.eval_date = DateTime.parse(Date.today.to_s)
    evaluation.save
    if request.xhr?
      render json: {'status': 'ok'}
    else
			flash[:error] = "No se pudo calificar correctamente"
    end
  end

	def feedback
		evaluation = Evaluation.find(params[:id])
    	evaluation.retro = params[:retro]
		puts evaluation.retro
		evaluation.save
    if request.xhr?
      render json: {'status': 'ok'}
    else
			flash[:error] = "No se pudo calificar correctamente"
    end
	end

	def add_professor
		@evaluation = Evaluation.find(params[:evaluation_id])
		@user = User.find(params[:user_id])
		@evaluation.users << @user
		if request.xhr?
      render json: {'status': 'ok'}
    else
			flash[:error] = "No se pudo agregar el profesor a la evaluación correctamente"
    end
	end

	def delete_professor
		@evaluation = Evaluation.find(params[:evaluation_id])
		@user = User.find(params[:user_id])
		@evaluation.users.delete(@user)
		if request.xhr?
      render json: {'status': 'ok'}
    else
			flash[:error] = "No se pudo eliminar al profesor de la evaluación correctamente"
    end
	end

	def create
		@error = false
		@minimum = false
		@competences = Competence.all
		@levels = Level.all
		@evidences = Evidence.where(user_id: current_user.id)
		ActiveRecord::Base.transaction do
			@interview = Interview.new(evaluated: false)
			if !(@interview.save!)
				@error = true
			end
			@reqDate = params[:evaluation][:reqDate]
			@selected_competences = params[:evaluation][:competences]


			@selected_competences.each do |key, value|
				@competence_id = key.to_i
				@desLevel_id = value[:level].to_i
				@selected_evidences = value[:evidences]

				if @desLevel_id === 0
					@level_id = Evaluation.where(competence_id: @competence_id).last.achLevel
					@evaluation = Evaluation.new(reqDate: @reqDate, competence_id: @competence_id, desLevel: 0, achLevel: @level_id, user_id: current_user.id, interview_id: @interview.id)
				else
					@evaluation = Evaluation.new(reqDate: @reqDate, competence_id: @competence_id, desLevel: @desLevel_id, user_id: current_user.id, interview_id: @interview.id)
					@minimum = true
				end


				if !(@evaluation.save!)
					@error = true
					break
				elsif @selected_evidences && @desLevel_id != 0
					@selected_evidences.each do |e|
						@evaluation_evidence = EvaluationEvidence.new(evaluation_id: @evaluation.id, evidence_id: e.to_i)
						if !@evaluation_evidence.save!
							@error = true
							break
						end
					end
				end
			end

			if !@error
				if @minimum
					flash[:success] = 'Solicitud de evaluación registrada exitosamente'
					redirect_to show_user_path(current_user, :anchor => "evaluaciones")
				else
					flash[:error] = 'Debes seleccionar al menos una competencia a evaluar.'
					render :action => 'new'
					raise ActiveRecord::Rollback
				end
			else
				flash[:error] = 'Ocurrió un error al guardar tu solicitud de evaluación. Inténtalo de nuevo'
				render :action => 'new'
				raise ActiveRecord::Rollback
			end
		end
	end


	def edit
		@interview = Interview.find(params[:id])
		@reqDate = Evaluation.where(interview_id: @interview.id).first.reqDate
		@evaluation = Evaluation.new
		@evaluations = Evaluation.where(interview_id: @interview.id)
		@competences = Competence.all
		@levels = Level.all
		@evidences = Evidence.where(user_id: current_user.id)
  	end

	def update
		@error = false
		@interview = params[:id]
		@reqDate = params[:evaluation][:reqDate]
		@competences = params[:evaluation][:competences]

		@competences.each do |key, value|
			@competence_id = key.to_i
			@desLevel_id = value[:level].to_i
			@evidences = value[:evidences]
			@evaluation_id = value[:evaluation_id]
			EvaluationEvidence.destroy_all(evaluation_id: @evaluation_id)

			@evaluation =  Evaluation.find(@evaluation_id)

			if @desLevel_id === 0
				@level_id = Evaluation.where(competence_id: @competence_id).last.achLevel
				@evaluation.update_attributes(achLevel: @level_id, desLevel: 0, reqDate: @reqDate)
			else
				@level_id = @desLevel_id
				@evaluation.update_attributes(achLevel: nil, desLevel: @level_id, reqDate: @reqDate)
			end


			if !(@evaluation.save)
				@error = true
				break
			elsif @evidences && @desLevel_id != 0
				@evidences.each do |e|
					@evaluation_evidence = EvaluationEvidence.new(evaluation_id: @evaluation.id, evidence_id: e.to_i)
					if !@evaluation_evidence.save
						@error = true
						break
					end
				end
			end
		end

		if !@error
			flash[:success] = 'Solicitud de evaluación modificada exitosamente'
			redirect_to show_user_path(current_user, :anchor => "evaluaciones")
		else
			flash[:error] = 'Ocurrió un error al modificar tu solicitud de evaluación. Inténtalo de nuevo'
			render :edit
		end

	end

	def set_evaluation
		@evaluation = evaluation.find(params[:id])
	end

	def evaluation_params
		params.require(:evaluation).permit(:reqDate, :evidences)
	end

	def destroy
		@error = false
		@interview = Interview.find(params[:id])
		@evaluations = Evaluation.where(interview_id: @interview.id)
    @evaluations.each do |eval|
      if eval.achLevel != nil
        @error = true
				break
      end
			if !(EvaluationEvidence.destroy_all(evaluation_id: eval.id) && eval.destroy)
				@error = true
				break
			end
		end
		if !@interview.destroy
			@error = true
		end
		if !@error
			flash[:success] = 'Evaluación eliminada exitosamente'
		else
			flash[:error] = 'Ocurrió un error al eliminar tu evaluación. Inténtalo de nuevo'
		end
		redirect_to show_user_path(current_user, :anchor => "evaluaciones")
	end
end
