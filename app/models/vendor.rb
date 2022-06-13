class Vendor < ApplicationRecord
  has_many :cards
  has_many :codetypes
end
