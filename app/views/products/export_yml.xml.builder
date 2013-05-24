xml.instruct!
xml.declare! :DOCTYPE, :yml_catalog, :SYSTEM, "shops.dtd"
xml.yml_catalog(:date => Time.now.strftime("%Y-%m-%d %H:%M")) do
    xml.shop do
        xml.name "Young Lovers"
        xml.company "Young Lovers"
        xml.url "#{request.protocol}#{request.host_with_port}"
        xml.currencies do
          xml.currency(:id => "RUR", :rate => 1)
        end
        xml.categories do
          xml.category("Одежда и обувь",       :id => 1)
          xml.category("Мужская одежда",       :id => 2, :parentId => 1)
          xml.category("Одежда",               :id => 3, :parentId => 2)
          xml.category("Белье и пляжная мода", :id => 4, :parentId => 2)
          xml.category("Мужская обувь",        :id => 5, :parentId => 2)
          
          @sections.each do |section|
            xml.category(section.name, :id => 100+section.id, :parentId => section.yml_parent_id)
          end
        end
        xml.local_delivery_cost Delivery.courier.first.price.to_i
        xml.offers do
          @products.each_with_index do |product, i|
            product.ru_sizes.each_with_index do |size, index|
              xml.offer(:id => i*10+index+1, :type => "vendor.model", :available => "true", :group_id => product.id) do
                xml.url product_url(product.uri)
                xml.price product.final_price
                xml.currencyId "RUR"
                xml.categoryId 100+product.section.id
                xml.market_category "Одежда, обувь и аксессуары/#{product.section.yml_category}"
                product.pictures.each do |img|
                  xml.picture "#{request.protocol}#{request.host_with_port}#{img.image.url(:zoom)}"
                end
                xml.store "false"
                xml.pickup "false"
                xml.delivery "true"
                xml.local_delivery_cost Delivery.courier.first.price.to_i
                xml.typePrefix product.section.yml_parent_id == 4 ? "Боксеры" : product.section.name
                xml.vendor product.brand.name
                xml.model product.name
                xml.description product.description

                if product.color?
                  xml.param(product.color, :name => "Цвет")
                end
                xml.param(size, :name => "Размер", :unit => "RU")
                xml.param("Мужской", :name => "Пол")
                xml.param("Взрослый", :name => "Возраст")
                xml.param(product.matter, :name => "Материал")
              end
            end
          end
        end
    end
end