class CreateVendors < ActiveRecord::Migration[7.0]
  def change
    create_table :vendors do |t|
      t.string :name, null: false, unique: true
      t.string :codetype

      t.timestamps
    end
  end
end
