ActiveAdmin.register Page do
  menu :priority => 100, :label => proc{ I18n.t("active_admin.pages") }
  
  index do
    selectable_column
    column :id
    column :name
    column :uri
    # column :description do |p|
    #   truncate(p.description, :length => 100)
    # end
    default_actions
  end
end
