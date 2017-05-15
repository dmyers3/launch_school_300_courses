module ApplicationHelper
  def format_url(url)
    url.start_with?("http://", "https://") ? url : "https://#{url}"  
  end
  
  def format_date(date)
    date = date.in_time_zone(current_user.time_zone) if current_user && current_user.time_zone
    date.strftime("%B %d, %Y at %l:%M %p %Z")
  end
end
