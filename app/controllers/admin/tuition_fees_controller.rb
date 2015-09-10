class Admin::TuitionFeesController < AdminController
  
  before_action :set_tf_id, :only=> [:show, :edit, :update, :destroy]
  before_action :look_ups, :only => [:edit, :new, :update]

  def index
    @tuition_fees = TuitionFee.all.order("year_level ASC")
  end

  def new
    @tuition_fee = TuitionFee.new
  end

  def create
    @tuition_fee = TuitionFee.new(tuition_fee_params)
    if @tuition_fee.save
      redirect_to "/admin/tuition_fees"
    else
      render :new
    end
  end

  def edit
  end

  def update
    # @tuition_fee = TuitionFee.find(params[:id])
    if @tuition_fee.update(tuition_fee_params)
      redirect_to "/admin/tuition_fees", notice: 'Tuition Fee was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tuition_fee.destroy
    redirect_to action: :index
  end

  private

  def set_tf_id
    @tuition_fee = TuitionFee.find(params[:id])
  end

  def look_ups
    @year_level = [['Grade 1','1'],['Grade 2','2'],['Grade 3','3'],['Grade 4','4'],['Grade 5','5'],['Grade 6','6'],
                   ['Grade 7','7'],['Grade 8','8'],['Grade 9','9'],['Grade 10','10'],['Grade 11','11'],['Grade 12','12']]
    @payment_type = [['Full Payment','1'],['Annual','2'],['Semestrial','3'],['Quarterly','4'],['LDP','5']]
  end

  def tuition_fee_params
    params.require(:tuition_fee).permit(:year_level, :tuition_fees, :misc_fees, :other_fees, :upon_enrollment, :payment_type)
  end

end
