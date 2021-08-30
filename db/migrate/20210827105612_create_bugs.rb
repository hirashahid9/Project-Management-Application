class CreateBugs < ActiveRecord::Migration[6.1]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.string :types
      t.string :status
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
