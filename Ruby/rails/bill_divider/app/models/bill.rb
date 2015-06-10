class Bill < ActiveRecord::Base
  has_many :breakdowns
  attr_accessible :company, :due_date, :total_amount

  validates_presence_of :company
  validates_presence_of :due_date
  validates_numericality_of :total_amount
end
