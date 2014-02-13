class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :name, presence: true
  validates :abbr, presence: true
  validates :team_id, presence: true
  validates :leader_id, presence: true
  validates :start_date, presence: true, date: { before: :end_date}
  validates :end_date, presence: true, date: { after: :start_date}

  before_save {self.abbr.upcase!}
end