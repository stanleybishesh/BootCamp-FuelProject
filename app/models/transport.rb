class Transport < ApplicationRecord
  # belongs_to :tenant
  has_many :line_items

  enum status: {
    available: "available",
    in_use: "in_use",
    maintenance: "maintenance",
    out_of_service: "out_of_service"
  }

  acts_as_tenant(:tenant)
end
