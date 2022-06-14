class RemoveCodetypeColumnFromVendors < ActiveRecord::Migration[7.0]
  def change
    remove_column :vendors, :codetype, :string
  end
end
