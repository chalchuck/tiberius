class VisitorsController < ResourceController

	def index
		@projects = current_user.projects
	end
end
