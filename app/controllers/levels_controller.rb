class LevelsController < ApplicationController

  def update_order
    new_order = params[:order]
    new_order.each do |level_id, order|
      Level.find(level_id).update_attribute(:order, order)
    end
  end

end
