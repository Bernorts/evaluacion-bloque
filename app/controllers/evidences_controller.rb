class EvidencesController < ApplicationController
  def new
    @new_evidence = Evidence.new
  end

  def create
    @evidence = Evidence.new(evidence_params)
    @evidence.date = DateTime.parse(Date.today.to_s).in_time_zone()+12*60*60
    @evidence.user = current_user
    if @evidence.save
      flash[:success] = "Evidencia creada correctamente"
      redirect_to show_user_path(current_user)
    else
      flash[:error] = "No fue posible crear la evidencia"
      redirect_to show_user_path(current_user)
    end
  end

  def edit
    @evidence = Evidence.find(params[:id])
  end

  def update
    @evidence = Evidence.find(params[:id])
		if @evidence.update_attributes(evidence_params)
		    flash[:success] = 'Evidencia modificada exitosamente'
		    redirect_to show_user_path(current_user)
  	else
      flash[:error] = "No fue posible modificar la evidencia"
      redirect_to show_user_path(current_user)
  	end
  end

  def destroy
    Evidence.find(params[:id]).destroy
    flash[:success] = "Evidencia eliminada exitosamente"
    redirect_to show_user_path(current_user)
  end

  def evidence_params
    params.require(:evidence).permit(:name, :url)
  end
end
