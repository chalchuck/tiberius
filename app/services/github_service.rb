class GithubService

	attr_accessor :user, :github

	def initialize(user)
	  @user = user
	  @github = Github.new
	end

	def fetch_user_repos
		user_repos = Github.new.repos.list(user: user.try(:login))
		Project.create_self(user_repos)
	end

	def fetch_project_milestones(project)
		issues = Github::Client::Issues.new user: user.try(:login)
		milestones = issues.milestones(repo: project.try(:name)).list
		Task.create_self(milestones, project)
	end

	def fetch_project_collaborators(project)
		return false unless project.github_id.present?
			collaborators = github.repos.contributors(user.try(:login), project.try(:name))
			User.create_self(collaborators, project)
		end
	end

	def fetch_milestone_tasks(project)
		issues = github.issues.list user: user.try(:login), repo: project.try(:name)
		issues.each do |issue|
			
			if issue['milestone'].present?
				task = Task.find_by_github_id(issue['milestone'])
				SubTask.create_self(issue, task)
			else
				Task.create_self_from_issue(issue, project)
			end

		end
	end

	def create_repo_on_github(project)
		# repo={
		#   "name": project.try(:name),
		#   "description": project.try(:description),
		#   "private": false
		# }
		# github.repos.create(repo)
	end

	def assign_to_owner_if_no_assignee
		
	end


end