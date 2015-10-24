class GithubService

	attr_accessor :user

	def initialize(user)
	  @user = user
	end

	def fetch_user_repos
		user_repos = Github.new.repos.list(user: user.try(:login))
		Project.create_self(user_repos)
	end


	def issues
		issues = Github::Client::Issues.new
		issues.milestones.list 'peter-murach', 'github', state: 'open'

		issues = Github::Client::Issues.new
		issues.milestones('peter-murach/github').list
		issues.milestones.list 'peter-murach/github'
	end


end