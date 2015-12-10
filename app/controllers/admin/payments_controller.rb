class Admin::PaymentsController < AdminController

  before_action :look_ups, :only => [:edit, :new, :update]
  
  def index
  end

  def new
    @payment = Payment.new

    # Variables
    @search_sn = params[:search]
    @payment_method = ""
    @tuition_detail = ""

    @student = Student.where(:student_number => @search_sn).first
    @details_tf = TuitionFee.where(:student_number => @search_sn).first

    # Payment Method
    if @details_tf.cash_basis_fee_id.nil?
      @payment_method = "Installment Basis Tuition Fee"
      @tuition_detail = InstallmentBasisFee.find(@details_tf.installment_basis_fee_id)
      @due_details = DueOfPayment.where(:installment_basis_fee_id => 14)
    else
      @payment_method = "Cash Basis Payment"
      
    end
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.generate_referrence_number
  end

  def show
    @payment = Payment.find(params[:id])
    @student = Student.where(:student_number => @payment.student_number).first
  end

  private

  def look_ups
    @school_years = SchoolYear.select("id, name").order("id ASC")
    @year_levels = YearLevel.select("id, name").order("id ASC")
    @pays = [['Tuition Fees',1],['School Uniforms',2],['P.E Uniforms', 3],['School Supplies',4]]
    @discounts = Discount.select("id, name, percentage, reason").order("id ASC")
  end

  def payment_params
    params.require(:payment).permit(:student_number, :school_year_id, :year_level_id, :payment_mode, :payment_terms,
      :referrence_number, :pay_id, :description, :discount_id, :amount_paid, :penalty, :date_paid, :received_by)
  end


end
