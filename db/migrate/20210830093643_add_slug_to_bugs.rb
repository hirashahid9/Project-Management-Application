class AddSlugToBugs < ActiveRecord::Migration[6.1]
  def change
    add_column :bugs, :slug, :string
    add_index :bugs, :slug, unique: true
  end
end
