class SchoolUniform < ActiveRecord::Base

  belongs_to :year_level
  belongs_to :school_year

  def get_level
    case self.level
    when 1
      "Pre-School"
    when 2
      "Elementary"
    when 3
      "Highschool"
    end
  end

  def get_gender
    case self.gender
    when 1
      "Male"
    when 2
      "Female"
    end
  end

end
