class Employee < ActiveRecord::Base

  def full_name
    self.first_name + " " + self.last_name  
  end

  def get_role
    case role_id
    when 0
      "Admin"
    when 1 
      "Teacher"
    when 2
      "Staff"
    when 3
      "Others"
    end
  end

end
