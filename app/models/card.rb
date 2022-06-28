class Card < ApplicationRecord
  belongs_to :user
  has_many :vendors
  attr_reader :codegenerator

  def self.barcode(codetype, value)
    Codetype.print_code(codetype, value)
  end
end
