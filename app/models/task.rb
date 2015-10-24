# == Schema Information
#
# Table name: tasks
#
#  closed_at         :datetime
#  closed_issues     :string
#  created_at        :datetime         not null
#  creator           :jsonb
#  description       :string
#  due_on            :datetime
#  github_created_at :datetime
#  github_id         :integer          indexed
#  github_updated_at :datetime
#  html_url          :string
#  id                :integer          not null, primary key
#  labels_url        :string
#  number            :string           indexed
#  open_issues       :string
#  project_id        :integer          indexed
#  state             :string
#  title             :string
#  updated_at        :datetime         not null
#  url               :string
#  user_id           :integer          indexed
#
# Indexes
#
#  index_tasks_on_github_id   (github_id)
#  index_tasks_on_number      (number)
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_user_id     (user_id)
#

class Task < ActiveRecord::Base

	############VALIDATIONS######################################################
	validates :github_id, uniqueness: {message: "%{value} is already in use"}, allow_blank: true
	validates :title, presence: {message: "A Project name is required"}, uniqueness: {message: "%{value} is already in user"}

	############ASSOCIATIONS#####################################################
	belongs_to :project
  belongs_to :user
  has_many :sub_tasks, :dependent => :destroy

	############CALLBACKS########################################################

	############SCOPES###########################################################

	#############################################################################

	def self.create_self(milestones, project)
		milestones.each	do |milestone|
			create(
				project: project,
				closed_at: milestone["closed_at"],
				closed_issues: milestone["closed_issues"],
				creator: milestone["creator"],
				description: milestone["description"],
				due_on: milestone["due_on"],
				github_created_at: milestone["created_at"],
				github_id: milestone["id"],
				github_updated_at: milestone["updated_at"],
				html_url: milestone["html_url"],
				labels_url: milestone["labels_url"],
				number: milestone["number"],
				open_issues: milestone["open_issues"],
				state: milestone["state"],
				title: milestone["title"],
				url: milestone["url"]
				)
		end
	end

	def self.create_self_from_issue(issue, project)
		create(
			project: project,
			closed_at: issue["closed_at"],
			creator: issue["user"],
			description: issue["body"],
			github_created_at: issue["created_at"],
			github_id: issue["id"],
			github_updated_at: issue["updated_at"],
			html_url: issue["html_url"],
			labels_url: issue["labels_url"],
			number: issue["number"],
			state: issue["state"],
			title: issue["title"],
			url: issue["url"]
		)
	end

end
