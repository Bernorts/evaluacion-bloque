class EvaluationsController < ApplicationController
	def new
		@competences = Competence.all
		@levels = Level.all
		@evaluation = Evaluation.new
		@evidences = Evidence.where(user_id: current_user.id)
	end

	def create
		@interview = Interview.new(evaluated: false)
		if !(@interview.save)
			@error = true
		end
		@interview.save
		@error = false
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
			redirect_to '/malla'
		else
			flash[:danger] = 'Ocurrió un error al guardar tu solicitud de evaluación. Inténtalo de nuevo'
			render :action => 'new'
		end
	end


	def edit
		@interview = Interview.find(params[:id])
		@evaluation = Evaluation.new
		@evaluations = Evaluation.where(interview_id: @interview.id)
		@competences = Competence.all
		@levels = Level.all
		@evidences = Evidence.where(user_id: current_user.id)
  	end

	def update
		@evaluation = evaluation.find(params[:id])
		if @evaluation.update_attributes(evaluation_params)
		    flash[:success] = 'Solicitud de revisión modificada exitosamente'
		    redirect_to '/malla'
	  	else
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
		@evaluation = evaluation.find(params[:id]).destroy
		redirect_to '/malla'
	end
end