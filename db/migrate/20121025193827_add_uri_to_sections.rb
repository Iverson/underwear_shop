class AddUriToSections < ActiveRecord::Migration
  def change
    add_column :sections, :uri, :string
  end
end
