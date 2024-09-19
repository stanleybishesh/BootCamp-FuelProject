class AddTimestampsToOrderGroups < ActiveRecord::Migration[6.1]
  def change
    add_timestamps :order_groups, null: true
  end
end
