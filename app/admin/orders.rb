# coding: utf-8
ActiveAdmin.register Order do
  menu :label => proc{ I18n.t("active_admin.orders") }, :parent => I18n.t("active_admin.orders")
  
  scope :all, :default => true
  
  Order.state_machine.states.each do |state|
    scope state.human_name
  end
  
  index do
    selectable_column
    column :id
    column "User" do |o|
      link_to o.address.fio, admin_order_path(o)
    end
    column "Summ (RUR)" do |o|
      o.total
    end
    column "Phone" do |o|
      o.address.phone
    end
    column "State" do |o|
      link_to o.human_state_name, edit_admin_order_path(o)
      
    end
    column :created_at
    default_actions
  end
  
  show do |order|
    attributes_table do
      row "Статус заказа" do
        order.human_state_name
      end
      row "Заказчик" do
        order.address.fio
      end
      row "Телефон" do
        order.address.phone
      end
      row "Метро" do
        order.address.metro
      end
      row "Адрес" do
        order.address.address
      end
      row "Комментарий заказчика" do
        order.comment
      end
    end

    panel "Товары" do
      table_for(order.order_items) do
        column "Артикул" do |item| 
          item.product.id
        end
        column "Название" do |item| 
          "#{item.name} (#{item.product.color})"
        end
        column "Цена" do |item| 
          item.price
        end
        column "Размер" do |item| 
          item.size
        end
        column "Кол-во" do |item| 
          item.count
        end
      end
      para "<div class='print-css customer_signature'><span>После оплаты товара претензии не принимаются. В случае обмена или возврата товара оплачивается доставка по тарифу - 300 руб.</span><br /><br /><br />Подпись клиента: </div>".html_safe
      
      para "Доставка: #{order.delivery ? order.delivery.calc_price(order.summ) : 'не указана'}"
      
      para "Итого: #{order.total}"
      para "<div class='print-css'><br /></div>".html_safe
    end
    
    # active_admin_comments
  end
  
  form do |f|
    f.inputs "Заказ" do
      
      #f.input :state
      f.input :state_event, :label => 'State', :as => :select, :collection => f.object.state_transitions.map{|s| [s.human_to_name , s.event]}, :include_blank => f.object.human_state_name
      f.input :delivery
      f.input :comment
      
      if f.object.new_record?
        f.object.build_address()
      end

      f.inputs "Адрес" do
        f.semantic_fields_for :address do |meta_form|
          meta_form.inputs :fio, :phone, :email, :metro, :address
        end
      end
      
      f.inputs "Товары" do
        f.has_many :order_items, :class => "b-aa-sizes-form " do |p|
          
          p.input :product_id, :as => :select, :multiple => false, :collection => Product.order(:id).map { |a| [ a.select_title, a.id ]}
          p.input :count
          p.input :size, :hint => (p.template.image_tag(p.object.product.preview(:small)) if p.object.product)
          
          p.input :_destroy, :as=>:boolean, :required => false, :label => 'Remove item'
        end 
      end
    end
    
    f.buttons
  end
end
