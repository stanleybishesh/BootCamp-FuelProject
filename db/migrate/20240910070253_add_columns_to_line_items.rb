class AddColumnsToLineItems < ActiveRecord::Migration[7.2]
  def change
    # add_column :line_items, :quantity, :integer
    # add_column :line_items, :delivery_order_id, :integer
    # add_index :line_items, :delivery_order_id
    # add_column :line_items, :merchandise_id, :integer
    # add_index :line_items, :merchandise_id
    add_column :line_items, :merchandise_category_id, :integer
    add_index :line_items, :merchandise_category_id
    add_column :line_items, :price, :float
    add_column :line_items, :unit, :string
  end
end
