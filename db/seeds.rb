if User.all.blank?
  User.create(:email => 'admin@gmsn.com', :password => 'password', :password_confirmation => 'password', :first_name => 'Guess', :last_name => 'Who' ,:role_id => 0)
end

# Example Data
if TuitionFee.all.blank?
  TuitionFee.create(:year_level => 1, :tuition_fees => 40000, :misc_fees => 10000, :other_fees => 2000, :upon_enrollment => 22000, :payment_type => 1, :total_fees => 52000)
end
