# encoding: utf-8


OrderState.delete_all
OrderState.create(:id=>1,:name=>"Recived")
OrderState.create(:id=>2,:name=>"Confirmed")
OrderState.create(:id=>3,:name=>"Delivery")
OrderState.create(:id=>4,:name=>"Paid")