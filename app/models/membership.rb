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

class Membership < ActiveRecord::Base


  ############VALIDATIONS######################################################
  validates :user, :project, presence: true

  ############ASSOCIATIONS#####################################################
  belongs_to :user
  belongs_to :project

  ############CALLBACKS########################################################
  # after_commit :send_out_activation_emails, on: :create

  ############SCOPES###########################################################

  #############################################################################


  def self.enrol!(user, project)
  	create(user: user, project: project)
  end


  def send_out_activation_emails
  	
  end
end
