ActiveAdmin.register Brand do
  menu :label => proc{ I18n.t("active_admin.brands") }, :parent => I18n.t("active_admin.products"), :priority => 3
  
  actions :all, :except => [:show]
  
  around_filter do |controller, action|
    Brand.class_eval do
      def to_param
        id.to_s
      end
    end

    begin
      action.call
    ensure
      Brand.class_eval do
        def to_param
          "#{uri}"
        end
      end
    end
  end
  
  index do
    column :id
    column :name do |brand|
      link_to brand.name, edit_admin_brand_path(brand)
    end
    column :created_at
    default_actions
  end
end
