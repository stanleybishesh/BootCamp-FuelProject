class AddManualUpdateFlagToOrderGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :order_groups, :manual_update, :boolean, default: false
  end
end
