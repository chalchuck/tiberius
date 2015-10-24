# == Schema Information
#
# Table name: projects
#
#  created_at  :datetime         not null
#  description :string
#  github_id   :integer
#  id          :integer          not null, primary key
#  name        :string           indexed
#  slug        :string           indexed
#  updated_at  :datetime         not null
#  user_id     :integer          indexed
#
# Indexes
#
#  index_projects_on_name     (name) UNIQUE
#  index_projects_on_slug     (slug) UNIQUE
#  index_projects_on_user_id  (user_id)
#

class Project < ActiveRecord::Base

	############VALIDATIONS######################################################
	validates :github_id, uniqueness: {message: "%{value} is already in use"}, allow_blank: true
	validates :name, presence: {message: "A Project name is required"}, uniqueness: {message: "%{value} is already in user"}
	validates :slug, presence: {message: "Project slug is required"}, uniqueness: {message: "%{value} is already in use"}
	validates :user, presence: {message: "A project needs to have an owner"}

	############ASSOCIATIONS#####################################################
	belongs_to :user
	has_many :memberships, dependent: :destroy
	has_many :collaborators, through: :memberships, source: :user

	############CALLBACKS########################################################
	after_commit :fetch_github_tasks, on: :create

	############SCOPES###########################################################

	#############################################################################


	def self.create_self(repos)
		repos.each do |repo|
			begin
				owner = User.find_by_login!(repos["owner"]["login"])
				create(
					github_id: repo["id"],
					name: repo["name"].humanize,
					description: repo["description"],
					slug: repo["name"],
					user: owner
					)
			rescue Exception => e
				e
			end				
		end
	end

private

	def fetch_github_tasks
		GithubService.new(user).project_tasks(self)
	end
end
