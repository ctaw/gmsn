class Admin::StudentsController < AdminController

  before_action :set_student_id, :only=> [:show, :edit, :update, :destroy]
  before_action :look_ups, :only => [:edit, :new, :update]

  def index
    @students = Student.select("id, last_name, first_name, student_number, year_level_id").order("id DESC").paginate(:page => params[:students], :per_page => 10)
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    payment_method = params[:student][:payment_method]
    @balance = params[:balance]
    puts ">>>>>>>>>"
    puts @balance
    puts ">>>>>>>>>"
    # if @student.save
    #   redirect_to "/admin/students"
    # else
    #   render :new
    # end
  end

  def show
    @tuition_fee = TuitionFee.where(:year_level => @student.year_level).first
    @payments = Payment.select("id, date_paid, amount_paid, referrence_number, discount_amount").where(:student_number => @student.student_number).order("date_paid DESC")
  end

  def edit
  end

  def update
  end

  def destroy
    @student.destroy
    redirect_to action: :index
  end

  private

  def set_student_id
    @student = Student.find(params[:id])
  end

  def look_ups
    @school_years = SchoolYear.select("id, name").order("id DESC")
    @year_levels = YearLevel.select("id, name").order("id ASC")
    @payment_methods = [['Cash Basis',1],['Installment Basis',2]]
    @gender = [['Male',1],['Female',2]]
  end

  def student_params
    params.require(:student).permit(:first_name, :middle_name, :last_name, :student_number, 
      :school_year_id, :payment_method, :year_level_id, :balance, :tuition_fee_id, 
      :guardian_name, :contact_number, :present_address, :gender)
  end

end
