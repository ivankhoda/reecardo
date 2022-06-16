class ChangeDataTypeForCardsCode < ActiveRecord::Migration[7.0]
  def change
    change_column :cards, :code, :string
  end
end
