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

    student = Student.where(:student_number => sn).first
    @balance = ""

    # ======== If Tuition Fee ========
    if pay_id = 1

      @tution = TuitionFee.where(:student_id => student.id).where(:student_number => student.student_number).first
      # ====== if Cash or Installment basis ======
      if !@tution.cash_basis_fee_id.nil?
        @tf = CashBasisFee.find(@tution.cash_basis_fee_id)
        @tuition_fee_amount = @tf.total_fee
      else
        @tf = InstallmentBasisFee.find(@tution.installment_basis_fee_id)
        @tuition_fee_amount = @tf.tuition_fee
      end
      
      # @tuition_fee_amount ( this is the total fee of the student )

    end
    # ======== If Tuition Fee ========

    # ======== SAVING PAYMENTS ========
    if @payment.save
      
      # if Student is Exist
      if TuitionFee.exists?(:student_number => @payment.student_number)
        
        # Check If there's a discount
        if @payment.discount_id.nil?

          puts ">>>>>>>>>>>>>>>>"
          puts "walang discount"

          # Update Existing Balance
          
          @updated_tuition = TuitionFee.find(@tution.id)
          
          if !@updated_tuition.balance.nil?
            @balance = (@updated_tuition.balance.to_f - @payment.amount_paid.to_f) - @payment.penalty.to_f
          else
            @balance = (@tuition_fee_amount.to_f - @payment.amount_paid.to_f) - @payment.penalty.to_f
          end
          
        else
          
          puts ">>>>>>>>>>>>>>>>"
          puts "may discount"

          # Get Discount Percentage
          @dis = Discount.find(@payment.discount_id)
          @dis_percent = @dis.percentage.to_f

          @tol_discount = (@tuition_fee_amount.to_f * @dis_percent) / 100
          puts ">>>>>>>>>>>>>"
          @balance = ((@tuition_fee_amount.to_f - @tol_discount.to_f) - @payment.amount_paid.to_f) - @payment.penalty.to_f
        end

      else
        redirect_to "/admin/students/new"
      end

      # After Saved
      @updated_tuition = TuitionFee.find(@tution.id)
      @updated_tuition.update(:balance => @balance)
      redirect_to "/admin/payments/#{@payment.id}"

    else
      render :new
    end
    # ======== SAVING PAYMENTS ========

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
    params.require(:payment).permit(:student_number, :school_year_id, :year_level_id, :referrence_number,
          :pay_id, :description, :discount_id, :amount_paid, :penalty, :date_paid, :received_by)
  end


end
