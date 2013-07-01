class AddIndexesToPromos < ActiveRecord::Migration
  def change
    add_index :promos, :state_id
    add_index :promos, :top
  end
end
