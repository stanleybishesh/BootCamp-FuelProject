class AddMainOrderGroupIdToOrderGroup < ActiveRecord::Migration[7.2]
  def change
    add_column :order_groups, :main_order_group_id, :integer
    add_index :order_groups, :main_order_group_id
  end
end
