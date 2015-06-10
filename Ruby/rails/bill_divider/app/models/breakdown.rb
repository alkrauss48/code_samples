class Breakdown < ActiveRecord::Base
  belongs_to :member
  belongs_to :bill
  attr_accessible :member_id, :amount, :late_payment, :missed_payment, :pay_date

  validates_presence_of :member_id
  validates_presence_of :amount
  validates_presence_of :pay_date
end
