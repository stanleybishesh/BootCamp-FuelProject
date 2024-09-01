class DeliveryOrder < ApplicationRecord
  belongs_to :order_group
  has_many :line_items
end
