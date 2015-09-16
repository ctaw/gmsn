class Admin::PaymentsController < AdminController

  before_action :look_ups, :only => [:edit, :new, :update]
  
  def index
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.generate_referrence_number

    sn = params[:payment][:student_number]
    pay_id = params[:payment][:pay_id]
    @discount_id = params[:payment][:discount_id]

    student = Student.where(:student_number => sn).first
    @balance = ""

    if pay_id = 1      
      
      @tution = TuitionFee.where(:student_id => student.id).where(:student_number => student.student_number).first
      
      if !@tution.cash_basis_fee_id.nil?
        @tf = CashBasisFee.find(@tution.cash_basis_fee_id)
        @tuition_fee_amount = @tf.total_fee
      else
        @tf = InstallmentBasisFee.find(@tution.installment_basis_fee_id)
        @tuition_fee_amount = @tf.tuition_fee
      end

    end

    if @payment.save

      if !@discount_id.nil?
        discount = Discount.find(@discount_id)
        discount_percent = discount.percentage 
        @balance = (@tuition_fee_amount.to_f - @payment.amount_paid.to_f)
      end
        @tuition.update_attributes(:balance => @balance)
        redirect_to "/admin/dashboard"
    else
      render :new
    end

  end

  def show
    @payment = Payment.find(params[:id])
    @student = Student.where(:student_number => @payment.student_number).first
  end

  private

  def look_ups
    @school_years = SchoolYear.select("id, name").order("id DESC")
    @year_levels = YearLevel.select("id, name").order("id ASC")
    @pays = [['Tuition Fees',1],['School Uniforms',2],['P.E Uniforms', 3],['School Supplies',4]]
    @discounts = Discount.select("id, name, percentage, reason").order("id ASC")
  end

  def payment_params
    params.require(:payment).permit(:student_number, :school_year_id, :year_level_id, :referrence_number,
          :pay_id, :description, :discount_id, :amount_paid, :date_paid, :received_by)
  end


end
