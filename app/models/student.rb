class Student < ActiveRecord::Base

  has_many :payment_histories
  belongs_to :year_level
  belongs_to :school_year
  
  def full_name
    self.first_name + " " + self.last_name  
  end

  def get_payment_method
    case self.payment_method
    when 1
      "Cash Basis Tuition Fee"
    when 2
      "Installment Basis Tuition Fee"
    end
  end

  def get_gender
    case self.gender
    when 1
      "Male"
    when 2
      "Female"
    end
  end

  def get_relationship
    case self.guardian_relationship
    when "1"
      "Father"
    when "2"
      "Mother"
    when "3"
      "Sister"
    when "4"
      "Brother"
    when "5"
      "Relative"
    end
  end

end
