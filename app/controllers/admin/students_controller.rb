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
    sy = params[:student][:school_year_id]
    yl = params[:student][:year_level_id]
    pyi = params[:student][:payment_terms_id]
    payment_method = params[:student][:payment_method]
    @cbf = ""
    @ibf = ""
    @balance = ""
    @due_id = ""

    # Getting TF
    if payment_method == "1"
      cash = CashBasisFee.where(:school_year_id => sy).where(:year_level_id => yl).first
      @student.tuition_fee_id = cash.id
      @cbf = cash.id

      if params[:balance] == ""
        @balance = cash.total_fee
      end
    else
      installment = InstallmentBasisFee.where(:school_year_id => sy).where(:year_level_id => yl).where(:payment_terms => pyi).first
      @student.tuition_fee_id = installment.id
      @ibf = installment.id
      if params[:balance] == ""
        @balance = installment.tuition_fee
      end
    end


    if @student.save
      @due_ids = DueOfPayment.where(:installment_basis_fee_id => @ibf).pluck(:id)
      @tuition = TuitionFee.new({:student_id => @student.id, :student_number => @student.student_number, :cash_basis_fee_id => @cbf, :installment_basis_fee_id => @ibf, :due_of_payment_ids => @due_ids, :balance => @balance})
      @tuition.save
      redirect_to "/admin/students"
    else
      render :new
    end

  end

  def show

    @tuition_fee = TuitionFee.where(:student_id => @student.id).where(:student_number => @student.student_number).first
    
    if !@tuition_fee.cash_basis_fee_id.nil?
      @student_tuition = CashBasisFee.find(@tuition_fee.cash_basis_fee_id)
    else
      @student_tuition = InstallmentBasisFee.find(@tuition_fee.installment_basis_fee_id)
    end
    
    @payments = Payment.select("date_paid, amount_paid, discount_id").where(:student_number => @student.student_number).order("date_paid DESC").paginate(:page => params[:payments], :per_page => 5)
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to "/admin/students"
    else
      render :edit
    end
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
    @relationships = [['Father',1],['Mother',2],['Sister',3],['Brother',4],['Relative',5]]
    @statuses = [['Active',1],['InActive',2]]
    @payment_terms = [['Monthly',1],['Quarterly',2],['Semi-Annual',3]]
  end

  def student_params
    params.require(:student).permit(:first_name, :middle_name, :last_name, :extension_name, :student_number, 
      :school_year_id, :payment_method, :payment_terms_id, :year_level_id, :balance, :tuition_fee_id, 
      :guardian_name, :guardian_relationship, :contact_number1, :contact_number2, :contact_number3, :present_address, :gender, :birth_date, :status)
  end

end
