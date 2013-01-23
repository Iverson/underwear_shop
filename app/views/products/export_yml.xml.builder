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
          xml.category("Мужская одежда", :id => 1)
          xml.category("Одежда", :id => 2, :parentId => 1)
          xml.category("Белье и пляжная мода", :id => 3, :parentId => 1)
          @sections.each do |section|
            xml.category(section.name, :id => 100+section.id, :parentId => section.yml_parent_id)
          end
        end
        xml.local_delivery_cost "250"
        xml.offers do
          @products.each do |product|
            product.product_instances.each do |instance|
              xml.offer(:id => instance.id, :type => "vendor.model", :available => "true") do
                xml.url product_url(product.uri)
                xml.price product.final_price
                xml.currencyId "RUR"
                xml.categoryId 100+product.section.id
                xml.market_category "Мужская одежда/#{product.section.yml_parent_id == 2 ? "Одежда" : "Белье и пляжная мода"}/#{product.section.name}"
                product.pictures.each do |img|
                  xml.picture "#{request.protocol}#{request.host_with_port}#{img.image.url(:zoom)}"
                end
                xml.store "false"
                xml.pickup "false"
                xml.delivery "true"
                xml.local_delivery_cost "250"
                xml.vendor product.brand.name
                xml.model product.name
                xml.description product.description

                if product.color?
                  xml.param(product.color, :name => "Цвет")
                end
                xml.param(instance.size, :name => "Размер", :unit => "INT")
                xml.param("Мужской", :name => "Пол")
                xml.param("Взрослый", :name => "Возраст")
              end
            end
          end
        end
    end
end