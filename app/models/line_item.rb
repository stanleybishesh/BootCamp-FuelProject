class LineItem < ApplicationRecord
  acts_as_tenant(:tenant)

  after_save :touch_order_group

  belongs_to :delivery_order
  belongs_to :merchandise_category
  belongs_to :merchandise

  private

  def touch_order_group
    if delivery_order.present? && delivery_order.order_group.present?
      delivery_order.order_group.touch
    else
      Rails.logger.error("OrderGroup not found for DeliveryOrder ##{delivery_order_id}")
    end
  end
end
