class AddUriToProducts < ActiveRecord::Migration
  def change
    add_column :products, :uri, :string
  end
end
