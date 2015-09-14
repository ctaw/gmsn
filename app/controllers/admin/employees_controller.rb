class Admin::EmployeesController < AdminController
  
  before_action :set_employee_id, :only=> [:show, :edit, :update, :destroy]
  before_action :look_ups, :only => [:edit, :new, :update]

  def index
    @employees = Employee.select("id, last_name, first_name, middle_name, role_id, date_hired").order("id DESC").paginate(:page => params[:employees], :per_page => 10)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to "/admin/employees"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to "/admin/employees", notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_employee_id
    @employee = Employee.find(params[:id])  
  end

  def look_ups
    @roles = [['Admin',0],['Teachers',1],['Staffs',2],['Others',3]]
  end

  def employee_params
    params.require(:employee).permit(:first_name, :middle_name, :last_name, :role_id, :date_hired)
  end

end
