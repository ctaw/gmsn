class Admin::SchoolSuppliesController < AdminController
  
  def index
    @school_supplies = SchoolSupply.select("id, name, amount").order("id ASC").paginate(:page => params[:school_supplies], :per_page => 10)
  end

  def new
    @school_supply = SchoolSupply.new
  end

  def create
    @school_supply = SchoolSupply.new(school_supply_params)
    if @school_supply.save
      redirect_to "/admin/school_supplies"
    else
      render :new
    end
  end

  def edit
    @school_supply = SchoolSupply.find(params[:id])
  end

  def update
    @school_supply = SchoolSupply.find(params[:id])
    if @school_supply.update(school_supply_params)
      redirect_to "/admin/school_supplies"
    else
      render :edit
    end
  end

  private

  def school_supply_params
    params.require(:school_supply).permit(:name, :amount)
  end

end
