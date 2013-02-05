# encoding: utf-8


OrderState.delete_all
OrderState.create(:id=>1,:name=>"Создан", :status=>"created")
OrderState.create(:id=>2,:name=>"Получен", :status=>"recived")
OrderState.create(:id=>3,:name=>"Подтвержден", :status=>"confirmed")
OrderState.create(:id=>4,:name=>"Доставка", :status=>"delivery")
OrderState.create(:id=>5,:name=>"Оплачен", :status=>"paid")
OrderState.create(:id=>6,:name=>"Отменен", :status=>"canceled")