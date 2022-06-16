class Card < ApplicationRecord
  belongs_to :user
  has_many :vendors

  def self.barcode(codetype, value)
    Codetype.print_code(codetype, value)
  end
end
