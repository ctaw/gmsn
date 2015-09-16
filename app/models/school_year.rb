class SchoolYear < ActiveRecord::Base
  has_many :cash_basis_fees
  has_many :installment_basis_fees
  has_many :students
end
