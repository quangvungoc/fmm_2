class Position < ActiveRecord::Base
  validates :name, presence: true
  validates :abbr, presence: true

  before_save {self.abbr.upcase!}
end