module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :notice then "alert-info"
    when :success then "alert-success"
    when :error || :alert then "alert-danger"
    else "alert-#{flash_type}"
    end
  end

  def flash_messages(_opts = {})
    flash.each do |msg_type, message|
      concat(
        tag.div(message, class: "alert #{bootstrap_class_for(msg_type)}",
          role: "alert",) do
          concat tag.button("x", class: "close",
            data: {dismiss: "alert"},)
          concat tag.span(message, data: {testid: "message"})
        end,
      )
    end
    nil
  end
end
