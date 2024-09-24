class MerchandiseCategory < ApplicationRecord
  has_many :line_items
  has_many :merchandises, dependent: :destroy

  acts_as_tenant(:tenant)
end
