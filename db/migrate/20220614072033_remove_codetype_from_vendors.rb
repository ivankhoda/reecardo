class RemoveCodetypeFromVendors < ActiveRecord::Migration[7.0]
  def change
    remove_reference :vendors, :codetype, null: false, foreign_key: true
  end
end
