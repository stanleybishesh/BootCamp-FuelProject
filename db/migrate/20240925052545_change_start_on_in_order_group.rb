class ChangeStartOnInOrderGroup < ActiveRecord::Migration[7.2]
  def change
    change_column :order_groups, :start_on, :datetime
  end
end
