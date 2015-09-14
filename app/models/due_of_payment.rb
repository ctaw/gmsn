class DueOfPayment < ActiveRecord::Base
  belongs_to :installment_basis_fees
end
