# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def get_menu_class(item,selected)
    return "class='selected'" if selected == item
    return "class='selected'" if selected.blank? and item == "advices"
    return "class='unselected'"
  end
end
