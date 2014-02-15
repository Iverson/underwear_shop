class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name, :null => false
      t.string :uri, :null => false
      t.text :text1
      t.text :text2
      t.text :text3

      t.timestamps
    end
    
    add_index :pages, :uri
  end
end
