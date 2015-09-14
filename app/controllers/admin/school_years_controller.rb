class Admin::SchoolYearsController < AdminController
  def index
    @school_years = SchoolYear.all.order("id DESC").paginate(:page => params[:school_years], :per_page => 10)
  end

  def new
    @school_year = SchoolYear.new
  end

  def create
    @school_year = SchoolYear.new(school_year_params)
    if @school_year.save
      redirect_to "/admin/school_years"
    else
      render :new
    end
  end

  def edit
    @school_year = SchoolYear.find(params[:id])
  end

  def update
    if @school_year.update(school_year_params)
      redirect_to "/admin/school_years"
    else
      render :edit
    end
  end

  private

  def school_year_params
    params.require(:school_year).permit(:name)
  end
end
