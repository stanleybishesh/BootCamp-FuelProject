class RemoveTenantIdFromMerchandises < ActiveRecord::Migration[7.2]
  def change
    remove_index :merchandises, :tenant_id
    remove_column :merchandises, :tenant_id, :integer
  end
end
