ActiveAdmin.register Product do
  before_filter do
    Product.class_eval do
      def to_param
        id.to_s
      end
    end
  end
  
  index do
    column :id
    column "Image" do |product|
      link_to(image_tag(product.preview(:small)), edit_admin_product_path(product))
    end
    column :name do |product|
      link_to product.name, edit_admin_product_path(product)
    end
    column :price
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
      f.input :discount
      f.input :section
      f.input :brand
      f.input :country
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
