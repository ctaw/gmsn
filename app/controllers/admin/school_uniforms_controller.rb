class Admin::SchoolUniformsController < AdminController
  
  before_action :set_school_uniform_id, :only=> [:show, :edit, :update, :destroy]
  before_action :look_ups, :only => [:edit, :new, :update]

  def index
    @school_uniforms = SchoolUniform.select("id, school_year_id, level, gender, uniform_size, amount").order("id ASC").paginate(:page => params[:school_uniforms], :per_page => 10)
  end

  def new
    @school_uniform = SchoolUniform.new
  end

  def create
    @school_uniform = SchoolUniform.new(school_uniform_params)
    if @school_uniform.save
      redirect_to "/admin/school_uniforms/#{@school_uniform.id}"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @school_uniform.update(school_uniform_params)
      redirect_to "/admin/school_uniforms/#{@school_uniform.id}"
    else
      render :edit
    end
  end

  private

  def set_school_uniform_id
    @school_uniform = SchoolUniform.find(params[:id])
  end

  def look_ups
    @school_years = SchoolYear.select("id, name").order("id DESC")
    @levels = [['Pre-School',1],['Elementary',2],['Highschool',3]]
    @gender = [['Male',1],['Female',2]]
  end

  def school_uniform_params
    params.require(:school_uniform).permit(:school_year_id, :level, :gender, :uniform_size, :amount)
  end

end
