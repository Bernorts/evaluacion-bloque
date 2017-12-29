class EvaluationsController < ApplicationController
	def new
		@competences = Competence.all
		@levels = Level.all
		@evaluation = Evaluation.new
		@evidences = Evidence.where(user_id: current_user.id)
	end

	def create
		@error = false
		@interview = Interview.new(evaluated: false)
		if !(@interview.save)
			@error = true
		end
		@reqDate = params[:evaluation][:reqDate]
		@competences = params[:evaluation][:competences]

		@competences.each do |key, value|
			@competence_id = key.to_i
			@desLevel_id = value[:level].to_i
			@evidences = value[:evidences]

			if @desLevel_id === 0
				@level_id = Evaluation.where(competence_id: @competence_id).last.achLevel
				@evaluation = Evaluation.new(reqDate: @reqDate, competence_id: @competence_id, desLevel: 0, achLevel: @level_id, user_id: current_user.id, interview_id: @interview.id)
			else
				@evaluation = Evaluation.new(reqDate: @reqDate, competence_id: @competence_id, desLevel: @desLevel_id, user_id: current_user.id, interview_id: @interview.id)
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
			flash[:success] = 'Solicitud de evaluación registrada exitosamente'
			redirect_to show_user_path(current_user, :anchor => "evaluaciones")
		else
			flash[:danger] = 'Ocurrió un error al guardar tu solicitud de evaluación. Inténtalo de nuevo'
			render :action => 'new'
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
			flash[:danger] = 'Ocurrió un error al modificar tu solicitud de evaluación. Inténtalo de nuevo'
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
			flash[:danger] = 'Ocurrió un error al eliminar tu evaluación. Inténtalo de nuevo'
		end
		redirect_to show_user_path(current_user, :anchor => "evaluaciones")
	end
end