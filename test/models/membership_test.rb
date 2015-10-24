# == Schema Information
#
# Table name: memberships
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  project_id :integer          indexed
#  updated_at :datetime         not null
#  user_id    :integer          indexed
#
# Indexes
#
#  index_memberships_on_project_id  (project_id)
#  index_memberships_on_user_id     (user_id)
#

require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
