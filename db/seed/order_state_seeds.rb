# encoding: utf-8


OrderState.delete_all
OrderState.create(:id=>1,:name=>"Создан", :status=>"created")
OrderState.create(:id=>2,:name=>"Подтвержден", :status=>"confirmed")
OrderState.create(:id=>3,:name=>"Доставка", :status=>"delivery")
OrderState.create(:id=>4,:name=>"Оплачен", :status=>"paid")