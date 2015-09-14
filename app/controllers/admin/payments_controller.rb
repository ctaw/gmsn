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
    @sn = params[:payment][:student_number]
    @s_id = Student.where(:student_number => @sn).first

    if @payment.save
      if !@s_id.nil?
        redirect_to "/admin/payments/#{@payment.id}"
      else
        redirect_to "/admin/students"
      end
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
    discounts = Discount.order("id ASC")
    @discounted = [['No', false],['Yes',true]]
  end

  def payment_params
    params.require(:payment).permit(:student_number, :referrence_number, :discounted, :discount_amount, :discount_id, :amount_paid, :date_paid)
  end


end
