class CreateDeliveryOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :delivery_orders do |t|
      t.integer :order_group_id
      t.string :source
      t.datetime :planned_at
      t.datetime :completed_at

      t.timestamps
    end
    add_index :delivery_orders, :order_group_id
  end
end
