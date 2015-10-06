class Discount < ActiveRecord::Base

  has_many :payments

  def get_discount
    self.name + " - " + self.reason + " - " + "#{self.percentage} %"
  end

  def get_percentage
    "#{self.percentage} %"
  end
end
