ActiveAdmin.register Section do
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
      link_to section.name, admin_section_path(section)
    end
    column :created_at
    default_actions
  end
      
  form do |f|
    f.inputs "New section" do
      f.input :name
      f.hidden_field :parent_id
      f.input :uri
    end
    f.buttons
  end
end
