class AddCodeTypeRefToCards < ActiveRecord::Migration[7.0]
  def change
    add_reference :cards, :codetype, null: false, foreign_key: true
  end
end
