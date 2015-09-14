class Student < ActiveRecord::Base

  has_many :payment_histories
  belongs_to :year_level
  
  def full_name
    self.first_name + " " + self.last_name  
  end

  def get_year_level
    @yl = self.year_level
    if @yl < 13
      "Grade #{@yl}"
    elsif @yl == 13
      "Nursery"
    elsif @yl == 14
      "Pre-School"
    else
      ""
    end
  end

end
