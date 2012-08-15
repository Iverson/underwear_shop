# encoding: utf-8


OrderState.delete_all
OrderState.create(:id=>1,:name=>"Создан")
OrderState.create(:id=>2,:name=>"Принят")
OrderState.create(:id=>3,:name=>"Подтвержден")
OrderState.create(:id=>4,:name=>"Доставка")
OrderState.create(:id=>5,:name=>"Оплачен")