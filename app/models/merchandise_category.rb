class MerchandiseCategory < ApplicationRecord
  has_many :line_items
  has_many :merchandises

  acts_as_tenant(:tenant)
end
