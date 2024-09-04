class Transport < ApplicationRecord
  # belongs_to :tenant
  has_many :line_items

  enum status: {
    available: 0,
    in_use: 1,
    maintenance: 2,
    out_of_service: 3
  }

  acts_as_tenant(:tenant)
end
