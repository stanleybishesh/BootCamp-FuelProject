class AddTimestampsToDeliveryOrderAndLineItem < ActiveRecord::Migration[7.0]
  def change
    add_timestamps :delivery_orders, null: true
    add_timestamps :line_items, null: true
  end
end
