module SectionsHelper
  def nested_sections(sections)
    if sections.length > 0
      html = sections.map do |section, sub_sections|
        
          '<li class="b-sections-tree__item">' + render(section) + nested_sections(sub_sections) + "</li>"
        
      end.join.html_safe
      
      return content_tag(:ul, html, :class => "b-sections-tree")
    else
      return ''
    end
  end
end
