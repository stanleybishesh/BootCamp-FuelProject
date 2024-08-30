class AddTenantIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :tenant_id, :integer
    add_index :users, :tenant_id
  end
end
