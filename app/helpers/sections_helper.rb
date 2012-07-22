module SectionsHelper
  def nested_sections(sections)
    sections.map do |section, sub_sections|
      render(section) + content_tag(:ul, nested_sections(sub_sections), :class => "b-sections-tree")
    end.join.html_safe
  end
end
