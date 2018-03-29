class InterviewsController < ApplicationController
  def show
    @evaluation = Evaluation.find(params[:id])
  end
end
