class AddCodeToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :code, :string
  end
end
