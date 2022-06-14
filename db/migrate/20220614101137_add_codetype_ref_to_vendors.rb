class AddCodetypeRefToVendors < ActiveRecord::Migration[7.0]
  def change
    add_reference :vendors, :codetype, null: false, foreign_key: true
  end
end
