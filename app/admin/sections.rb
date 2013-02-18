ActiveAdmin.register Section do
  menu :label => proc{ I18n.t("active_admin.sections") }, :parent => I18n.t("active_admin.products"), :priority => 2
  
  actions :all, :except => [:show]
  
  around_filter do |controller, action|
    Section.class_eval do
      def to_param
        id.to_s
      end
    end

    begin
      action.call
    ensure
      Section.class_eval do
        def to_param
          "#{uri}"
        end
      end
    end
  end
  
  index do
    column :id
    column :name do |section|
      link_to section.name, edit_admin_section_path(section)
    end
    column :created_at
    default_actions
  end
      
  form do |f|
    f.inputs "New section" do
      f.input :name
      f.hidden_field :parent_id
      f.input :uri
      f.input :yml_parent_id
      f.input :yml_category
      f.input :description
    end
    f.buttons
  end
end
