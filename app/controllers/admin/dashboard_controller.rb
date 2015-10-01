class Admin::DashboardController < AdminController
  
  def index
    @users = User.count
    @students = Student.count

    # Total Cash
    @total_cash = Payment.where(date_paid: 1.week.ago..Date.today).sum(:amount_paid)

    # TF
    @tuition_cash = Payment.where(pay_id: 1).where(date_paid: 1.week.ago..Date.today).sum(:amount_paid)

    # Other Fee
    @other_cash = Payment.where("pay_id !=?", 1).where(date_paid: 1.week.ago..Date.today).sum(:amount_paid)

    @employees = User.where("role_id !=?", 0).count

    @todays_payments = Payment.select("id, student_number, amount_paid").where(date_paid: Date.today).order('id DESC').paginate(:page => params[:todays_payments], :per_page => 5)

  end

end
