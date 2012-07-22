class AddPurchaisePriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :purchaise_price, :decimal, :precision => 6, :scale => 2
  end
end
