module ApplicationHelper
  def react_component(component, props = {}, tag = 'div')
    id = "react-#{component.underscore.dasherize}"
    data = { camelized_props: ReactHelper.camelize_props(props.as_json) }

    content_tag tag, id: id, data: data do
      javascript_pack_tag component
    end
  end
end
