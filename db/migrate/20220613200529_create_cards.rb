class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :vendor, null: false
      t.string :alias
      t.integer :code
      t.boolean :favorite

      t.timestamps
    end
  end
end
