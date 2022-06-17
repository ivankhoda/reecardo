class Card < ApplicationRecord
  belongs_to :user
  has_many :vendors
  attr_reader :codegenerator

  def initialize(codegenerator)
    @codegenerator = codegenerator
  end

  def self.barcode(codetype, value)
    Codetype.print_code(codetype, value)
  end

  def self.code
    codegenerator.print_code
  end
end
