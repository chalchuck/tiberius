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

	############CALLBACKS########################################################
	after_commit :fetch_github_repos, on: :create

	############SCOPES###########################################################
	
	#############################################################################

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

private

	def fetch_github_repos
		GithubService.new(self).fetch_user_repos
	end

end
