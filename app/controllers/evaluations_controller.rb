class EvaluationsController < ApplicationController
	def new
		@competences = Competence.all
		@levels = Level.all
		@evaluation = Evaluation.new
	end

	def create
		@error = false
		@reqDate = params[:evaluation][:reqDate]
		@competences = params[:evaluation][:competences]
		@competences.each do |key, value|
			@competence_id = key.to_i
			@level_id = value[:level].to_i
			if not @level_id === 0
				@desLevel = CompetenceLevel.find_by(competence_id: @competence_id, level_id: @level_id).id
				@evaluation = Evaluation.new(reqDate: @reqDate, desLevel: @desLevel)
				if !@evaluation.save
					@error = true
					break
				end
			end
		end
			
		if !@error
			flash[:success] = 'Solicitud de revisión registrada exitosamente'
			redirect_to '/malla'
		else
			flash[:danger] = 'Ocurrió un error al guardar tu solicitud de evaluación. Inténtalo de nuevo'
			render :action => 'new'
		end
	end

	def edit
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