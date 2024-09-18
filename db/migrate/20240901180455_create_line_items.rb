class CreateLineItems < ActiveRecord::Migration[7.2]
  def change
    create_table :line_items do |t|
      t.integer :quantity
      t.integer :delivery_order_id
      t.integer :merchandise_id
      t.integer :transport_id

      t.timestamps
    end
    add_index :line_items, :delivery_order_id
    add_index :line_items, :merchandise_id
    add_index :line_items, :transport_id
  end
end
