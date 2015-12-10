module ApplicationHelper

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def format_date(date)
    return date.blank? ? "" : date.strftime("%B %d, %Y")
  end

  def today_date
    DateTime.now.to_date
  end
  
end
