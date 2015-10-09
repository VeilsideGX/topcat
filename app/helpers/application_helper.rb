module ApplicationHelper
  def active_class(path)
    path == request.path ? "active" : ""       
  end
end
