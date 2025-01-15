module ReactHelper
  def react_component(name, props = {}, options = {})
    options = {
      tag: :div,
      class: options[:class],
      data: {
        react_component: name,
        react_props: props.to_json
      }
    }

    content_tag(options[:tag], nil, options)
  end
end