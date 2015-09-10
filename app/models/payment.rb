class Payment < ActiveRecord::Base

  after_save :update_balance

  belongs_to :student

  def generate_referrence_number
    self.referrence_number = SecureRandom.hex(8) 
  end

  private

  def update_balance
    student = Student.where(:student_number => self.student_number).first
    tf = TuitionFee.where(:year_level => student.year_level).first
    u_balance = (student.balance - self.amount_paid)

    #if there's a discount
    discount = self.discount_amount
    u_d_balance = ((student.balance - self.amount_paid) - discount)

    if discount.nil?
      student.update_attributes(:balance => u_balance.to_f)
    else
      student.update_attributes(:balance => u_d_balance.to_f)
    end
  end

end
