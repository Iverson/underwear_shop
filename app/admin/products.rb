# encoding: utf-8
ActiveAdmin.register Product do
  menu :label => proc{ I18n.t("active_admin.products") }, :parent => I18n.t("active_admin.products"), :priority => 1
  
  actions :all, :except => [:show]
  
  scope :all, :default => true
  Section.all.each do |section|
    scope section.name
  end
  
  scope_to do
    Class.new do
      def self.products
        Product.unscoped
      end
    end
  end
  
  before_filter do
    Product.class_eval do
      def to_param
        id.to_s
      end
    end
  end
  
  controller do
    def update
      update! do |format|
        format.html { redirect_to edit_admin_product_path }
      end
    end
  end
  
  index do
    selectable_column
    column :id
    column "Image" do |product|
      link_to(image_tag(product.preview(:small)), edit_admin_product_path(product))
    end
    column :name do |product|
      link_to product.name, edit_admin_product_path(product)
    end
    column :price do |product|
      product.final_price
    end
    column :section
    column :brand
    column :description
    default_actions
  end
  
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Product", :multipart => true do
      f.input :name
      f.input :uri
      f.input :price
      f.input :discount, :hint => "Конечная цена: #{f.object.final_price}"
      f.input :section
      f.input :brand
      f.input :country
      f.input :color
      f.input :matter
      f.input :description
      f.input :state
      
      if f.object.new_record?
        f.object.product_instances.build(:size => "all")
      end
      
      f.inputs "Sizes" do
        f.has_many :product_instances, :class => "b-aa-sizes-form " do |p|
          p.input :size
          p.input :count
        end 
      end
      
      if f.object.new_record?
        f.object.pictures.build()
      end
      
      f.inputs "Product images" do
        f.has_many :pictures do |p|
          p.input :image, :as => :file, :label => "Image",:hint => p.object.image.nil? ? p.template.content_tag(:span, "No Image Yet") : p.template.image_tag(p.object.image.url(:small))
          p.input :_destroy, :as=>:boolean, :required => false, :label => 'Remove image'
        end 
      end
      
    end
    
    f.buttons
  end
end
