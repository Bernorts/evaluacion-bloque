class EvidencesController < ApplicationController
  def new
    @new_evidence = Evidence.new
  end

  def create
    @evidence = Evidence.new(evidence_params)
    @evidence.date = DateTime.parse(Date.today.to_s).in_time_zone()+12*60*60
    if @evidence.save
      flash[:success] = "Evidencia creada correctamente"
      redirect_to show_user_path(current_user)
    else
      render 'new'
    end
  end

  def evidence_params
    params.require(:evidence).permit(:name, :url)
  end
end
