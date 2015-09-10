class Payment < ActiveRecord::Base

  belongs_to :student

  def generate_referrence_number
    self.referrence_number = SecureRandom.hex(8) 
  end

end
