class Member < ActiveRecord::Base
  has_many :breakdowns
  attr_accessible :birth_date, :first_name, :initials, :last_name

  validates_presence_of :initials
  validates_presence_of :first_name
  validates_presence_of :last_name
end
