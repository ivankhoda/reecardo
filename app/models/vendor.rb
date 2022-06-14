class Vendor < ApplicationRecord
  has_many :cards

  def supported?(name)
    p find_by_name(name:)
  end
end
