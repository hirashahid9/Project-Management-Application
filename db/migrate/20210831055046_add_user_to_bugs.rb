class AddUserToBugs < ActiveRecord::Migration[6.1]
  def change
    add_reference :bugs, :creator, null: false, foreign_key: { to_table: :users }
    add_reference :bugs, :developer, foreign_key: { to_table: :users }
  end
end
