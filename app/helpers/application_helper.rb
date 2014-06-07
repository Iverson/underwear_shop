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
  
  def menu_sections_tree(sections, active_section_id, active_parent_id)
    if sections.length > 0
      html = sections.map do |section, sub_sections|
          klass = ""
          klass = "b-sections-menu__item" if section.parent == nil
          klass += " b-sections-menu__item_sub" if sub_sections.length > 0
          klass += " active" if section.id == active_section_id || section.id == active_parent_id

          p "______________"
          p active_section_id
          p active_parent_id

          "<li class='#{klass}'>" + render(:partial => 'shared/menu_item', :locals => {:section => section, :sub_sections => sub_sections, :active_section_id => active_section_id}) + '<ul class="b-sections-menu">' + menu_sections_tree(sub_sections, active_section_id, active_parent_id) + "</ul>" + "</li>"
        
      end.join.html_safe
      
      return html
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
    (item['attrs']['price']*(100 - [item['attrs']['promo_discount'].to_i, item['attrs']['discount'].to_i].max)/100).to_i
  end
  
  def get_content(page, block)
    if page
      page[block].html_safe
    else
      "Content not found..."
    end
  end

end
