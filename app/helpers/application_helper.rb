module ApplicationHelper
  def current_user
    Current.user
  end

  def flash_class(type)
    {
      "notice" => "alert-info",
      "alert" => "alert-danger",
      "error" => "alert-danger",
      "success" => "alert-success"
    }[type]
  end
end
