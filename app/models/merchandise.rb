class Merchandise < ApplicationRecord
  # belongs_to :tenant
  has_many :line_items

  enum status: {
    available: 0,
    out_of_stock: 1
  }

  acts_as_tenant(:tenant)
end
