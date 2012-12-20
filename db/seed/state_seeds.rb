# encoding: utf-8


State.delete_all
State.create(:id=>1,:name=>"Неопубликован", :status=>"unpublished")
State.create(:id=>2,:name=>"Опубликован", :status=>"published")