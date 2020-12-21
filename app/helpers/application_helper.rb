module ApplicationHelper
  def react_component(component, props = {}, tag = 'div')
    id = "react-#{component.underscore.dasherize}"
    data = { camelized_props: ReactHelper.camelize_props(props.as_json) }

    content_tag tag, id: id, data: data do
      javascript_pack_tag component
    end
  end

  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info",
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end
end
