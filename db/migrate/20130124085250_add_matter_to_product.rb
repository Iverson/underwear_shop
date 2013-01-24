# coding: utf-8
class AddMatterToProduct < ActiveRecord::Migration
  def change
    add_column :products, :matter, :string, :null => false, :default => "Хлопок"
  end
end
