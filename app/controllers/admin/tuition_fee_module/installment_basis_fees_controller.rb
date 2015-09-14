class Admin::TuitionFeeModule::InstallmentBasisFeesController < Admin::TuitionFeeModuleController
  
  before_action :set_installment_id, :only=> [:show, :edit, :update, :destroy]
  before_action :look_ups, :only => [:edit, :new, :update]

  def index
  end

  def new
    @installment_basis_fee = InstallmentBasisFee.new
  end

  def create
    @installment_basis_fee = InstallmentBasisFee.new(installment_params)
    if @installment_basis_fee.save
      redirect_to "/admin/tuition_fee_module/installment_basis_fees/#{@installment_basis_fee.id}"
    else
      render :new
    end
  end

  def show    
  end

  def edit
  end

  def update
    if @installment_basis_fee.update(installment_params)
      redirect_to "/admin/tuition_fee_module/installment_basis_fees/#{@installment_basis_fee.id}"
    else
      render :edit
    end
  end

  def delete
  end

  private

  def set_installment_id
    @installment_basis_fee = InstallmentBasisFee.find(params[:id])
  end

  def look_ups
    @school_years = SchoolYear.select("id, name").order("id DESC")
    @year_levels = YearLevel.select("id, name").order("id ASC")
    @payment_terms = [['Monthly',1],['Quarterly',2],['Semi-Annual',3]]
  end

  def installment_params
    params.require(:installment_basis_fee).permit(:school_year_id, :year_level_id, :payment_terms, :tuition_fee, :down_payment, :other_fee, due_of_payments_attributes: [:installment_basis_fee_id, :due_date, :amount, :_destroy])
  end

end
