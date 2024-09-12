class AddColumnsToDeliveryOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :delivery_orders, :order_group_id, :integer
    add_index :delivery_orders, :order_group_id
    add_column :delivery_orders, :source, :string
    add_column :delivery_orders, :vehicle_type, :string
    add_column :delivery_orders, :transport_id, :integer
    add_index :delivery_orders, :transport_id
    add_column :delivery_orders, :courier_id, :integer
    add_index :delivery_orders, :courier_id
  end
end
