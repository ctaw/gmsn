class Admin::PeUniformsController < AdminController
  
  before_action :set_pe_uniform_id, :only=> [:show, :edit, :update, :destroy]
  before_action :look_ups, :only => [:edit, :new, :update]

  def index
    @pe_uniforms = PeUniform.select("id, uniform_size, amount, uniform_type").order("id ASC").paginate(:page => params[:pe_uniforms], :per_page => 10)
  end

  def new
    @pe_uniform = PeUniform.new
  end

  def create
    @pe_uniform = PeUniform.new(pe_uniform_params)
    if @pe_uniform.save
      redirect_to "/admin/pe_uniforms/#{@pe_uniform.id}"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @pe_uniform.update(pe_uniform_params)
      redirect_to "/admin/pe_uniforms/#{@pe_uniform.id}"
    else
      render :edit
    end
  end

  private

  def set_pe_uniform_id
    @pe_uniform = PeUniform.find(params[:id])
  end

  def look_ups
    @types = [['T-Shirt',1],['Jogging Pants',2]]
  end

  def pe_uniform_params
    params.require(:pe_uniform).permit(:uniform_size, :amount, :uniform_type)
  end

end
