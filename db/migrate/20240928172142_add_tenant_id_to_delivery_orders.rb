class AddTenantIdToDeliveryOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :delivery_orders, :tenant_id, :integer
    add_index :delivery_orders, :tenant_id
  end
end
