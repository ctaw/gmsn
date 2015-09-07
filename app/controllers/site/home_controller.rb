class Site::HomeController < SiteController
  def index
    redirect_to "/login"
  end
end
