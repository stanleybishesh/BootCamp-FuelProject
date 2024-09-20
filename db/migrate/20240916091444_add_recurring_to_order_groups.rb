class AddRecurringToOrderGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :order_groups, :recurring, :jsonb
  end
end
