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
    
    if Student.exists?(:student_number => @search_sn)

      @student = Student.where(:student_number => @search_sn).first
      @details_tf = TuitionFee.where(:student_number => @search_sn).first

      # Payment Method
      if @details_tf.cash_basis_fee_id.nil?
        @payment_method = "Installment Basis Tuition Fee"
        @tuition_detail = InstallmentBasisFee.find(@details_tf.installment_basis_fee_id)
        # @due_details = DueOfPayment.where(:installment_basis_fee_id => 14)
        @due_details = PenaltyChecker.where(:student_number => @search_sn)
        @due_dates = PenaltyChecker.where(:student_number => @search_sn).where(:is_paid => 0)

      else
        @payment_method = "Cash Basis Payment"
        
      end
    else

      flash[:notice] = "Student Number doesn't exist!"
      redirect_to "/admin/payments/"

    end
  end

  def create
    @payment = Payment.new(payment_params)
    
    @student = Student.where(:student_number => params[:payment][:student_number]).first

    @payment.school_year_id = @student.school_year_id
    @payment.year_level_id = @student.year_level_id
    @payment.payment_mode = @student.payment_method
    @payment.payment_terms = @student.payment_terms_id
    @payment.referrence_number = @payment.generate_referrence_number
    
    

    # SAVE PAYMENT
    if @payment.save

      # Update Penalty Checker
      @paid_due = params[:due_date]
      @update_penalty = PenaltyChecker.find(@paid_due)
      @update_penalty.update_attributes(:is_paid => 1)

      # Update Balance
      @tf_update = TuitionFee.where(:student_number => params[:payment][:student_number]).first
      @balance_update = TuitionFee.find(@tf_update.id)
      ####Computation ---->
      @balance = (@tf_update.balance.to_f - @payment.amount_paid.to_f)
      @balance_update.update_attributes(:balance => @balance.to_f)

      redirect_to "/admin/payments/#{@payment.id}"
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
