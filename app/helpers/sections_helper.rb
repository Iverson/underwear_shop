module SectionsHelper
  def nested_sections(sections)
    sections.map do |section, sub_sections|
        '<li class="b-sections-tree__item">' + render(section, :locals => { :qwe => sub_sections }) + content_tag(:ul, nested_sections(sub_sections), :class => "b-sections-tree") + "</li>"
    end.join.html_safe
  end
end
