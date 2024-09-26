class ChangeStatusInOrderGroupFromIntegerToString < ActiveRecord::Migration[7.2]
  def change
    change_column :order_groups, :status, :string
  end
end
