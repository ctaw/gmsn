class Admin::StudentsController < AdminController

  before_action :set_student_id, :only=> [:show, :edit, :update, :destroy]
  before_action :look_ups, :only => [:edit, :new, :update]

  def index
    @students = Student.select("id, last_name, first_name, student_number, year_level, balance").order("id DESC").paginate(:page => params[:students], :per_page => 10)
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    
    # Get Tuition Fee match in yearl level
    @yr_lvl = params[:student][:year_level]
    @fee_id = TuitionFee.where(:year_level => @yr_lvl).first
    @student.tuition_fee_id = @fee_id.id

    # If Fully Paid
    if @fp == 1
      @student.balance = 0
    elsif params[:student][:balance] == ""
      @student.balance = @fee_id.total_fees
    else
      @student.balance = ""
    end
    
    if @student.save
      redirect_to "/admin/students"
    else
      render :new
    end
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
    @year_level = [['Grade 1','1'],['Grade 2','2'],['Grade 3','3'],['Grade 4','4'],['Grade 5','5'],['Grade 6','6'],
                   ['Grade 7','7'],['Grade 8','8'],['Grade 9','9'],['Grade 10','10'],['Grade 11','11'],['Grade 12','12']]
    @payment_method = [['Full Payment','1'],['Annual','2'],['Semestrial','3'],['Quarterly','4'],['LDP','5']]
    @gender = [['Male',1],['Female',2]]
  end

  def student_params
    params.require(:student).permit(:first_name, :middle_name, :last_name, :student_number, 
      :school_year, :payment_method, :year_level, :balance, :tuition_fee_id, 
      :guardian_name, :contact_number, :present_address)
  end

end
