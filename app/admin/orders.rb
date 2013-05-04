# coding: utf-8
ActiveAdmin.register Order do
  menu :label => proc{ I18n.t("active_admin.orders") }, :parent => I18n.t("active_admin.orders")
  
  scope :all, :default => true
  OrderState.all.each do |state|
    scope state.name
  end
  
  index do
    selectable_column
    column :id
    column "User" do |o|
      link_to o.address.fio, admin_order_path(o)
    end
    column "Summ (RUR)" do |o|
      o.summ
    end
    column "Phone" do |o|
      o.address.phone
    end
    column "State" do |o|
      link_to o.order_state.name, edit_admin_order_path(o)
      
    end
    column :created_at
    default_actions
  end
  
  show do |order|
    attributes_table do
      row :order_state_id
      row "Заказчик" do
        order.address.fio
      end
      row "Телефон" do
        order.address.phone
      end
      row "Город" do
        order.address.city
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
        column "Название" do |item| 
          item.name
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
      para "Доставка: #{order.delivery.price}"
      
      para "Итого: #{order.summ}"
    end
    
    active_admin_comments
  end
  
  form do |f|
    f.inputs "Заказ" do
      f.input :order_state
      f.input :delivery
      f.input :comment
      
      if f.object.new_record?
        f.object.build_address()
      end

      f.inputs "Адрес" do
        f.semantic_fields_for :address do |meta_form|
          meta_form.inputs :fio, :phone, :email, :city, :address
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
