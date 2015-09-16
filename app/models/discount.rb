class Discount < ActiveRecord::Base

  def get_discount
    self.name + " - " + self.reason + " - " + "#{self.percentage} %"
  end
end
