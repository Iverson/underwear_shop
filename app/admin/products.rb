# encoding: utf-8
ActiveAdmin.register Product do
  menu :label => proc{ I18n.t("active_admin.products") }, :parent => I18n.t("active_admin.products"), :priority => 1

  filter :by_section, :as => :select, :collection => Section.all, :label => "Section"
  filter :state
  filter :brand
  filter :country
  filter :price
  filter :name
  filter :description
  filter :discount
  filter :created_at
  filter :updated_at
  filter :uri
  filter :color
  filter :matter
  filter :top

  actions :all, :except => [:show]
  
  scope :all, :default => true
  Section.all.each do |section|
    scope section.name.gsub(/\s+/, "_").gsub(/\.+/, "_")
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
    column "Stock" do |product|
      product.stock
    end
    column :section
    column :brand
    column :description do |p|
      truncate(p.description, :length => 100)
    end
    default_actions
  end
  
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Product", :multipart => true do
      f.input :name
      f.input :uri
      f.input :price, :as => :string
      f.input :purchaise_price, :as => :string
      f.input :discount, :as => :string, :hint => "Конечная цена: #{f.object.final_price}" if !f.object.new_record?
      f.input :section
      f.input :brand
      f.input :country
      f.input :color
      f.input :matter
      f.input :description
      f.input :state
      f.input :top, :as => :string
      
      if f.object.new_record?
        f.object.product_instances.build(:size => "all")
      end
      
      f.inputs "Sizes" do
        f.has_many :product_instances, :class => "b-aa-sizes-form " do |p|
          p.input :size, :as => :string
          p.input :count, :as => :string
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
