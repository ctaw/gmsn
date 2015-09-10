class TuitionFee < ActiveRecord::Base

  def get_payment_type
    case self.payment_type
    when 1
      "Annual"
    when 2
      "Semestrial"
    when 3
      "Quarterly"
    when 4
      "LDP"
    else
      "Fully Paid"
    end
  end

end
