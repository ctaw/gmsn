class AdminController < ApplicationController
  # devise method
  before_filter :authenticate_user!
  # define the layout
  # inside views/layouts/admin.html.slim
  layout 'admin'
end
