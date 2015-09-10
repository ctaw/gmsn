class Student < ActiveRecord::Base

  has_many :payment_histories
  
  def full_name
    self.first_name + " " + self.last_name  
  end

end
