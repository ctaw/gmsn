class Admin::TuitionFeeModule::CashBasisFeesController < Admin::TuitionFeeModuleController
  
  before_action :set_cash_basis_id, :only=> [:show, :edit, :update, :destroy]
  before_action :look_ups, :only => [:edit, :new, :update]

  def index
    @cash_basis_fees = CashBasisFee.select("id, school_year_id, year_level_id, tuition_fee, miscellaneous, total_fee").order("id DESC").paginate(:page => params[:cash_basis_fees], :per_page => 10)
  end

  def new
    @cash_basis_fee = CashBasisFee.new
  end

  def create
    @cash_basis_fee = CashBasisFee.new(cash_params)
    @tf = params[:cash_basis_fee][:tuition_fee]
    @mf = params[:cash_basis_fee][:miscellaneous]
    @of = params[:cash_basis_fee][:other_fee]
    @cash_basis_fee.total_fee = (@tf.to_f + @mf.to_f + @of.to_f)
    if @cash_basis_fee.save
      redirect_to "/admin/tuition_fee_module/cash_basis_fees/#{@cash_basis_fee.id}"
    else
      render :new
    end
  end

  def show
  end

  def edit    
  end

  def update
    @tf = params[:cash_basis_fee][:tuition_fee]
    @mf = params[:cash_basis_fee][:miscellaneous]
    @of = params[:cash_basis_fee][:other_fee]
    @cash_basis_fee.total_fee = (@tf.to_f + @mf.to_f + @of.to_f)
    if @cash_basis_fee.update(cash_params)
      redirect_to "/admin/tuition_fee_module/cash_basis_fees/#{@cash_basis_fee.id}"
    else
      render :edit
    end
  end

  private

  def set_cash_basis_id
    @cash_basis_fee = CashBasisFee.find(params[:id])
  end

  def look_ups
    @school_years = SchoolYear.select("id, name").order("id DESC")
    @year_levels = YearLevel.select("id, name").order("id ASC")
  end

  def cash_params
    params.require(:cash_basis_fee).permit(:school_year_id, :year_level_id, :tuition_fee, :miscellaneous, :total_fee)
  end
end
