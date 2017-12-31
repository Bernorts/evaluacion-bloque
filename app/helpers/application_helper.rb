module ApplicationHelper
	def getSemesters
		@current_user = current_user
		return @semesters = @current_user.semesters
	end
end
