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
	validates :slug, uniqueness: {message: "%{value} is already in use"}, allow_blank: true
	validates :user, presence: {message: "A project needs to have an owner"}

	############ASSOCIATIONS#####################################################
	belongs_to :user
	has_many :memberships, dependent: :destroy
	has_many :tasks, :dependent => :destroy
	has_many :collaborators, through: :memberships, source: :user

	############CALLBACKS########################################################
	after_commit :fetch_project_collaborators, on: :create
	before_save :make_slug
	############SCOPES###########################################################

	#############################################################################

	def to_s
		try(:name)
	end


	def push_to_github
		
	end

	def make_slug
		self[:slug] = self.name.gsub(/s\+/,'')
	end


	def self.create_self(repos)
		repos.each do |repo|
			begin
				owner = User.find_by_login!(repos["owner"]["login"])
				create(
					github_id: repo["id"],
					name: repo["name"].humanize,
					description: repo["description"],
					slug: repo["name"].gsub(/s\+/,''),
					user: owner
					)
			rescue Exception => e
				e
			end				
		end
	end

private

	def fetch_project_collaborators
		GithubService.new(user).fetch_project_collaborators(self)
	end
end
