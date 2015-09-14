class PeUniform < ActiveRecord::Base

  belongs_to :year_level
  belongs_to :school_year

  def get_type
    case self.uniform_type
    when 1
      "T-Shirt"
    when 2
      "Jogging Pants"
    end
  end

end
