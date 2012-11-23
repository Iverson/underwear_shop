module ApplicationHelper
  def sections_for_select(roots)
    grouped_options = []
    
    roots.each do |item|
      item_arr = []
      children_arr = []
      item_arr.push(item.name)
      
      item.children.each do |child|
        
        child.subtree.each do |tree_item|
          children_arr.push([tree_item.name, tree_item.id])
        end
        
      end
      item_arr.push(children_arr)
      
      grouped_options.push(item_arr)
    end
    
    return grouped_options
    
  end
  
  def menu_sections_tree(sections)
    if sections.length > 0
      html = sections.map do |section, sub_sections|
        
          '<li class="b-sections-menu__item">' + render(:partial => 'shared/menu_item', :locals => {:section => section, :sub_sections => sub_sections}) + menu_sections_tree(sub_sections) + "</li>"
        
      end.join.html_safe
      
      return content_tag(:ul, html, :class => "b-sections-menu")
    else
      return ''
    end
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def price(item)
    item['attrs']['price']*(100 - [item['attrs']['promo_discount'].to_i, item['attrs']['discount'].to_i].max)/100
  end

end
