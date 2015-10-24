# == Schema Information
#
# Table name: sub_tasks
#
#  closed_at         :datetime
#  comments          :string
#  comments_url      :string
#  created_at        :datetime         not null
#  events_url        :string
#  github_created_at :datetime
#  github_id         :integer
#  github_updated_at :datetime
#  html_url          :string
#  id                :integer          not null, primary key
#  labels            :string
#  labels_url        :string
#  locked            :string
#  number            :string
#  state             :string
#  task_id           :integer          indexed
#  title             :string
#  updated_at        :datetime         not null
#  url               :string
#
# Indexes
#
#  index_sub_tasks_on_task_id  (task_id)
#

class SubTask < ActiveRecord::Base

	############VALIDATIONS######################################################
	validates :github_id, uniqueness: {message: "%{value} is already in use"}, allow_blank: true
	validates :title, presence: {message: "A sub task name is required"}, uniqueness: {message: "%{value} is already in user"}

	############ASSOCIATIONS#####################################################
	belongs_to :task

	############CALLBACKS########################################################

	############SCOPES###########################################################

	#############################################################################


	def create_self(issue, task)
		create(task: task,
			url: issue['url'],
			labels_url: issue['labels_url'],
			comments_url: issue['comments_url'],
			events_url: issue['events_url'],
			html_url: issue['html_url'],
			github_id: issue['id'],
			number: issue['number'],
			title: issue['title'],
			labels: issue['labels'],
			state: issue['state'],
			locked: issue['locked'],
			comments: issue['comments'],
			github_created_at: issue['created_at'],
			github_updated_at: issue['updated_at'],
			closed_at: issue['closed_at']
			)
	end
end
