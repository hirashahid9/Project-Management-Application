class AddIndexManagerToProjects < ActiveRecord::Migration[6.1]
  def change
    add_index :projects, :manager_id
  end
end
