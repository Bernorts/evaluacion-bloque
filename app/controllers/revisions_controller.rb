class RevisionsController < ApplicationController
	def new
		@competences = Competence.all
		@levels = Level.all
		@revision = Revision.new
	end

	def create
		@revision = Revision.new(revision_params)
		if @revision.save
		  flash[:success] = 'Solicitud de revisión registrada exitosamente'
		  redirect_to '/malla'
		else
		  render :action => 'new'
		end
	end

	def edit
  	end

	def update
	@revision = Revision.find(params[:id])
		if @revision.update_attributes(revision_params)
		    flash[:success] = 'Solicitud de revisión modificada exitosamente'
		    redirect_to '/malla'
	  	else
	    	render :edit
	  	end
	end

	def set_revision
		@revision = Revision.find(params[:id])
	end

	def revision_params
		Rails.logger.debug params.inspect
		params.require(:revision).permit(:date, :evidences)
	end

	def destroy
		@revision = Revision.find(params[:id]).destroy
		redirect_to '/malla'
	end
end
