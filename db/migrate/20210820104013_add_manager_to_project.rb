class AddManagerToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :manager_id, :integer
  end
end
