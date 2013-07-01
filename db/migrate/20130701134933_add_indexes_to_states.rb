class AddIndexesToStates < ActiveRecord::Migration
  def change
    add_index :states, :status
  end
end
