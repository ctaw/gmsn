class Admin::DiscountsController < AdminController
  
  before_action :set_discount_id, :only=> [:show, :edit, :update, :destroy]

  def index
    @discounts = Discount.select("id, name, percentage, reason").order("id ASC")
  end

  def new
    @discount = Discount.new
  end

  def create
    @discount = Discount.new(discount_params)
    if @discount.save
      redirect_to "/admin/discounts"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @discount.update(discount_params)
      redirect_to "/admin/discounts"
    else
      render :edit
    end
  end

  private

  def set_discount_id
    @discount = Discount.find(params[:id])
  end

  def discount_params
    params.require(:discount).permit(:name, :percentage, :reason)
  end

end
