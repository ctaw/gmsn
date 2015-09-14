class Admin::TuitionFeeModuleController < AdminController
  def index
    @cash_basis_fees = CashBasisFee.select("id, school_year_id, year_level_id, tuition_fee, miscellaneous, total_fee").
                      order("id ASC").
                      paginate(:page => params[:cash_basis_fees], :per_page => 5)
    @installment_basis_fees = InstallmentBasisFee.select("id, school_year_id, year_level_id, payment_terms, tuition_fee, down_payment").
                      order("id ASC").paginate(:page => params[:installment_basis_fees], :per_page => 5)
  end
end
