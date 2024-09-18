class AddColumnsToOrderGroups < ActiveRecord::Migration[7.2]
  def change
    # add_column :order_groups, :tenant_id, :integer
    # add_index :order_groups, :tenant_id
    add_column :order_groups, :client_id, :integer
    add_index :order_groups, :client_id
    add_column :order_groups, :venue_id, :integer
    add_index :order_groups, :venue_id
    # add_column :order_groups, :start_on, :date
    # add_column :order_groups, :completed_on, :datetime
    # add_column :order_groups, :status, :string
  end
end
