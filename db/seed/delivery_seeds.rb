# encoding: utf-8


Delivery.delete_all
Delivery.create(:id=>1,:name=>"Курьером", :price=>250)
Delivery.create(:id=>2,:name=>"Самовывоз")