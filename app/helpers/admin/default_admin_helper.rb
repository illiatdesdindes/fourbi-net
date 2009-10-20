module Admin::DefaultAdminHelper

  def changed? attribute_name
    @changes && @changes.include?(attribute_name)
  end

  def display_value(name, value, text_after = nil)
    "<div class=\"displayValue\">#{name} : #{value}#{text_after}</div>"
  end

  def display_image(image, width = nil, height = nil)
    "<p>#{image_tag image, :width => width, :height => height}</p>"
  end

  def display_image_value_changed(image, attribute_name, width = nil, height = nil)
    if changed? attribute_name
      "<p>#{image_tag image, :class => 'imageChanged', :width => width, :height => height}</p>"
    else
      "<p>#{image_tag image, :width => width, :height => height}</p>"
    end
  end

  def display_value_changed(name, value, attribute_name, text_after = nil)
    if changed? attribute_name
      "<p>#{name} :<span class='changed'> #{value}#{text_after}</span></p>"
    else
      "<p>#{name} : #{value}#{text_after}</p>"
    end
  end

  def edit_value(name, value)
    "<div><label>#{name}</label> #{value}</div>"
  end

  def link_or_current name, options
    link_to_unless_current(name, options, {}) do
      name + " &#60;"
    end
  end


  def link_to_view(object, controller = nil, link_name = 'Voir')
    if controller
      link_to link_name, {:controller => controller, :action => :show, :id => object}
    else
      link_to link_name, {:action => :show, :id => object}
    end
  end

  def link_to_edit(object, controller = nil)
    if controller
      link_to 'Éditer', {:controller => controller, :action => :edit, :id => object}
    else
      link_to 'Éditer', {:action => :edit, :id => object}
    end
  end

  def delete_button(object, controller = nil)
    if controller
      button_to 'Supprimer', {:controller =>controller, :action => :'delete', :id => object },
                :confirm => 'En &ecirc;tes vous certain ?',
                :method => :delete, :id => 'deleteButton'
    else
      button_to 'Supprimer', {:action => :'delete', :id => object },
                :confirm => 'En &ecirc;tes vous certain ?',
                :method => :delete, :id => 'deleteButton'
    end
  end

  def link_to_delete(object, controller = nil)
    if controller
      link_to 'Supprimer', {:controller =>controller, :action => :'delete', :id => object },
              :confirm => 'En &ecirc;tes vous certain ?',
              :method => :delete, :id => 'deleteButton'
    else
      link_to 'Supprimer', {:action => :'delete', :id => object },
              :confirm => 'En &ecirc;tes vous certain ?',
              :method => :delete, :id => 'deleteButton'
    end
  end

end
