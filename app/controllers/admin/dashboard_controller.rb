class Admin::DashboardController < AdminController
  
  def index
    @users = User.count
    @students = Student.count
    @total_cash = Payment.where(date_paid: 1.week.ago..Date.today).sum(:amount_paid)
    @employees = User.where("role_id !=?", 0).count
  end

end
