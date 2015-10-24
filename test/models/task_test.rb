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

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
