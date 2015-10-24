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

require 'test_helper'

class SubTaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
