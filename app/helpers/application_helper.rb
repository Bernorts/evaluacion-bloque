# frozen_string_literal: true

module ApplicationHelper
  def getSemesters
    @current_user = current_user
    @semesters = @current_user.semesters
  end
end
