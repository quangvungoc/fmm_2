class Team < ActiveRecord::Base
  belongs_to :leader, class_name: 'User', foreign_key: 'leader_id'
  has_many :members, class_name: 'User'
  has_many :projects

  before_destroy :remove_members

  private
  def remove_members
    self.members.delete_all
  end
end