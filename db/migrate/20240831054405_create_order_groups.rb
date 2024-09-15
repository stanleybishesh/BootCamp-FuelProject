class CreateOrderGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :order_groups do |t|
      t.integer :tenant_id
      t.date :start_on
      t.datetime :completed_on
      t.integer :status

      t.timestamps
    end
    add_index :order_groups, :tenant_id
  end
end
