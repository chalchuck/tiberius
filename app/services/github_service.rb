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


	def issues(project)
		issues = Github::Client::Issues.new
		issues.milestones.list 'peter-murach', 'github', state: 'open'

		issues = Github::Client::Issues.new
		issues.milestones('peter-murach/github').list
		issues.milestones.list 'peter-murach/github'
	end


	def fetch_project_collaborators(project)
		collaborators = github.repos.contributors(user.try(:login), project.try(:name))
		User.create_self(collaborators, project)
	end


end