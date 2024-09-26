class RemoveColumnsFromDeliveryOrders < ActiveRecord::Migration[7.2]
  def change
    remove_column :delivery_orders, :planned_at, :datetime
    remove_column :delivery_orders, :completed_at, :datetime
  end
end
