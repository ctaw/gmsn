class Payment < ActiveRecord::Base


  belongs_to :student
  belongs_to :discount

  def generate_referrence_number
    self.referrence_number = SecureRandom.hex(8) 
  end

  
end
