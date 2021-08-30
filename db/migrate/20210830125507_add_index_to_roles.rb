class AddIndexToRoles < ActiveRecord::Migration[6.1]
  def change
    add_index :roles, :name
  end
end
