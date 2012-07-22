# encoding: utf-8


State.delete_all
State.create(:id=>1,:name=>"Unpublished")
State.create(:id=>2,:name=>"Published")