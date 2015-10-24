# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  name        :string
#  provider    :string
#  uid         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  login       :string
#  image       :string
#  credentials :jsonb
#  extra       :jsonb
#

class User < ActiveRecord::Base

	############VALIDATIONS######################################################
	############ASSOCIATIONS#####################################################
	has_many :projects, dependent: :destroy
	has_many :memberships, dependent: :destroy
	has_many :collaborations, through: :memberships, source: :project
	has_many :tasks, :dependent => :destroy

	############CALLBACKS########################################################
	after_commit :fetch_github_repos, on: :create

	############SCOPES###########################################################
	
	#############################################################################

	def to_s
		try(:name) or try(:login)
	end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider    = auth['provider']
      user.uid         = auth['uid']
      user.credentials = auth["credentials"]
      user.extra       = auth["extra"]
      if auth['info']
         user.name  = auth['info']['name']     || ""
         user.login = auth['info']['nickname'] || ""
         user.image = auth['info']['image']    || ""
      end
    end
  end

  def create_self(collaborators, project)
  	collaborators.each do |collaborator|
  		user = create(login: collaborator["login"], image: collaborator["avatar_url"])
  		Membership.enrol!(user, project)
  	end
  end


  # {"login"=>"kgathi2",
  #  "id"=>259633,
  #  "avatar_url"=>"https://avatars.githubusercontent.com/u/259633?v=3",
  #  "gravatar_id"=>"",
  #  "url"=>"https://api.github.com/users/kgathi2",
  #  "html_url"=>"https://github.com/kgathi2",
  #  "followers_url"=>"https://api.github.com/users/kgathi2/followers",
  #  "following_url"=>"https://api.github.com/users/kgathi2/following{/other_user}",
  #  "gists_url"=>"https://api.github.com/users/kgathi2/gists{/gist_id}",
  #  "starred_url"=>"https://api.github.com/users/kgathi2/starred{/owner}{/repo}",
  #  "subscriptions_url"=>"https://api.github.com/users/kgathi2/subscriptions",
  #  "organizations_url"=>"https://api.github.com/users/kgathi2/orgs",
  #  "repos_url"=>"https://api.github.com/users/kgathi2/repos",
  #  "events_url"=>"https://api.github.com/users/kgathi2/events{/privacy}",
  #  "received_events_url"=>"https://api.github.com/users/kgathi2/received_events",
  #  "type"=>"User",
  #  "site_admin"=>false,
  #  "contributions"=>1}



private

	def fetch_github_repos
		GithubService.new(self).fetch_user_repos
	end

end
