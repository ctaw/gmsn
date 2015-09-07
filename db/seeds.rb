if User.all.blank?
  User.create(:email => 'admin@gmsn.com', :password => 'password', :password_confirmation => 'password', :first_name => 'Guess', :last_name => 'Who' ,:role_id => 0)
end
