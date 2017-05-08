module ApplicationHelper
  def format_url(url)
    url.start_with?("http://", "https://") ? url : "https://#{url}"  
  end
  
  def format_date(date)
    date.strftime("%B %d, %Y at %l:%M %p %Z")
  end
end
