class YearLevel < ActiveRecord::Base
  has_many :cash_basis_fees
  has_many :installment_basis_fees
  has_many :students
  has_many :school_uniforms
  has_many :pe_uniforms
  has_many :school_suppliers
end
