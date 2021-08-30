class AddIndexToBugs < ActiveRecord::Migration[6.1]
  def change
    add_index :bugs, :status
    add_index :bugs, :types
  end
end
