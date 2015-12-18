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
        @ins_tuition_detail = InstallmentBasisFee.find(@details_tf.installment_basis_fee_id)
        @due_details = PenaltyChecker.where(:student_number => @search_sn)
        @due_dates = PenaltyChecker.where(:student_number => @search_sn).where(:is_paid => 0)

      else
        @cash_tuition_detail = CashBasisFee.find(@details_tf.cash_basis_fee_id)
        @due_dates = PenaltyChecker.where(:student_number => @search_sn).where(:is_paid => 0)
        @payment_method = "Cash Basis Payment"
        
      end


    else

      flash[:notice] = "Student Number doesn't exist!"
      redirect_to "/admin/payments/"

    end

    @hi = ""

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

  def discount_checker
    

    @f = 0;
    @s = 0;
    @t = 0;

    @total_discount = 0;

    @sn = params[:student_number]
    @f = params[:first_discount]
    @s = params[:second_discount]
    @t = params[:third_discount]

    @get_student = TuitionFee.where(:student_number => @sn).first
    @get_balance = @get_student.balance.to_f



    if @f.to_i > 0 && @s.to_i <=0 && @t.to_i <=0

      @f_discount = Discount.find(@f)
      @dis_percentage = @f_discount.percentage
      @dis = (@dis_percentage.to_f/100)

      @sub_to_total = (@get_balance.to_f * @dis.to_f)
      @total_amount_discounted = (@get_balance - @sub_to_total)

      @none = "Total"
    elsif @f.to_i > 0 && @s.to_i > 0 && @t.to_i <=0
      
      # ======= 1st Discount
      @f_discount = Discount.find(@f.to_i)
      @dis_percentage1 = @f_discount.percentage

      @dis1 = (@dis_percentage1.to_f/100)
      @sub_to_total1 = (@get_balance.to_f * @dis1.to_f)
      @total_discount1 = (@get_balance.to_f - @sub_to_total1.to_f)

      # ======= 2nd Discount
      @s_discount = Discount.find(@s.to_i)
      @dis_percentage2 = @s_discount.percentage

      @dis2 = (@dis_percentage2.to_f/100)
      @sub_to_total2 = (@total_discount1.to_f * @dis2.to_f)
      @total_discount2 = (@total_discount1.to_f - @sub_to_total2.to_f)

      @total_amount_discounted = @total_discount2.to_f
      
      @none = "Total"
    elsif @f.to_i > 0 && @s.to_i > 0 && @t.to_i > 0

      # ======= 1st Discount
      @f_discount = Discount.find(@f.to_i)
      @dis_percentage1 = @f_discount.percentage

      @dis1 = (@dis_percentage1.to_f/100)
      @sub_to_total1 = (@get_balance.to_f * @dis1.to_f)
      @total_discount1 = (@get_balance.to_f - @sub_to_total1.to_f)

      # ======= 2nd Discount
      @s_discount = Discount.find(@s.to_i)
      @dis_percentage2 = @s_discount.percentage

      @dis2 = (@dis_percentage2.to_f/100)
      @sub_to_total2 = (@total_discount1.to_f * @dis2.to_f)
      @total_discount2 = (@total_discount1.to_f - @sub_to_total2.to_f)

      
      # ======= 3rd Discount
      @t_discount = Discount.find(@t.to_i)
      @dis_percentage3 = @t_discount.percentage

      @dis3 = (@dis_percentage3.to_f/100)
      @sub_to_total3 = (@total_discount2.to_f * @dis3.to_f)
      @total_discount3 = (@total_discount2.to_f - @sub_to_total3.to_f)

      @total_amount_discounted = @total_discount3.to_f
      


      @none = "Total"
    else
      @none = "Select Discount"
    end

    
    respond_to do |format| 
      format.js { render :action => "discount" }
    end 

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
      :referrence_number, :pay_id, :description, :first_discount_id, :two_discount_id, :third_discount_id, :amount_paid, :penalty, :date_paid, :received_by)
  end


end
