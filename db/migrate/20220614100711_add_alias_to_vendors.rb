class AddAliasToVendors < ActiveRecord::Migration[7.0]
  def change
    add_column :vendors, :alias, :string, null: false
  end
end
