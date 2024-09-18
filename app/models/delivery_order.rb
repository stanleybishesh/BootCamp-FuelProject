class DeliveryOrder < ApplicationRecord
  belongs_to :order_group
  belongs_to :transport
  belongs_to :courier
  has_many :line_items, dependent: :destroy

  accepts_nested_attributes_for :line_items
end
