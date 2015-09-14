class CashBasisFee < ActiveRecord::Base
  belongs_to :school_year
  belongs_to :year_level
end
