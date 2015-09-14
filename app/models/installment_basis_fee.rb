class InstallmentBasisFee < ActiveRecord::Base

  has_many :due_of_payments
  belongs_to :school_year
  belongs_to :year_level

  accepts_nested_attributes_for :due_of_payments,  :reject_if => :all_blank, :allow_destroy => true
  

  def get_payment_terms
    case self.payment_terms
    when 1
      "Monthly"
    when 2
      "Quarterly"
    when 3
      "Semi-Annual"
    end
  end
end
