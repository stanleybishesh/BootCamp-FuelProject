class AddTenantIdToLineItems < ActiveRecord::Migration[7.2]
  def change
    add_column :line_items, :tenant_id, :integer
    add_index :line_items, :tenant_id
  end
end
