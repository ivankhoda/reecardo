class CreateCodetypes < ActiveRecord::Migration[7.0]
  def change
    create_table :codetypes do |t|
      t.string :name, null: false
      t.string :alias, null: false

      t.timestamps
    end
  end
end
