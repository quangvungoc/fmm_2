class Team < ActiveRecord::Base
  belongs_to :leader, class_name: 'User', foreign_key: 'leader_id'
  has_many :members, class_name: 'User'
end