class OrderGroup < ApplicationRecord
  enum status: {
    pending: 0,
    processing: 1,
    delivered: 2,
    cancelled: 3
  }

  has_one :delivery_order
  belongs_to :tenant
end
