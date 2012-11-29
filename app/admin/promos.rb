ActiveAdmin.register Promo do
  
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Promo", :multipart => true do
      f.input :name
      f.input :price
      f.input :discount
      f.input :text
      f.input :state
      
      f.inputs "Promo image", :for => [:promo_image, f.object.promo_image || PromoImage.new] do |p|
        p.input :image, :as => :file, :label => "Image",:hint => p.object.image.nil? ? p.template.content_tag(:span, "No Image Yet") : p.template.image_tag(p.object.image.url(:slideshow))
        p.input :_destroy, :as=>:boolean, :required => false, :label => 'Remove image'
      end
      
      if f.object.new_record?
        f.object.promo_items.build()
      end
      
      f.inputs "Promo items" do
        f.has_many :promo_items, :class => "b-aa-sizes-form " do |p|
          
          p.input :product_id, :as => :select, :multiple => false, :collection => Product.all
          p.input :count
          p.input :_destroy, :as=>:boolean, :required => false, :label => 'Remove item'
        end 
      end
      
    end
    
    f.buttons
  end
  
end