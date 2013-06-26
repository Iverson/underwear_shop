ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard_title") }
  
  content :title => proc{ I18n.t("active_admin.dashboard_title") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #       span :class => "blank_slate" do
    #         span "Welcome to Active Admin. This is the default dashboard page."
    #         small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
    #       end
    #     end

    # Here is an example of a simple dashboard with columns and panels.
    #
    
    
   para content_tag(:div, link_to('Export XML(YML)', "#{yml_path}.xml"), :style => "text-align: right;")
        
    columns do
      column do
        panel I18n.t("active_admin.index.column1") do
          table_for Order.where(:order_state_id => 2) do |f|
            f.column :id
            f.column "User" do |o|
              link_to o.address.fio, admin_order_path(o)
            end
            f.column "Phone" do |o|
              o.address.phone
            end
            f.column "Summ (RUR)" do |o|
              o.total
            end
            f.column "Date" do |o|
              o.created_at
            end
            f.column "State" do |o|
              link_to o.order_state.name, edit_admin_order_path(o)
              
            end
          end
        end
      end

      column do
        panel I18n.t("active_admin.index.column2") do
          table_for Order.where(:order_state_id => 3) do |f|
            f.column :id
            f.column "User" do |o|
              link_to o.address.fio, admin_order_path(o)
            end
            f.column "Phone" do |o|
              o.address.phone
            end
            f.column "Address" do |o|
              o.address.address
            end
            f.column "Summ (RUR)" do |o|
              o.summ
            end
            f.column "Date" do |o|
              o.created_at
            end
            f.column "State" do |o|
              link_to o.order_state.name, edit_admin_order_path(o)
              
            end
          end
        end
      end
    end
  end # content
end
