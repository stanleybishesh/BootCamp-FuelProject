class AddTenantIdToMerchandiseCategories < ActiveRecord::Migration[7.2]
  def change
    add_column :merchandise_categories, :tenant_id, :integer
    add_index :merchandise_categories, :tenant_id
  end
end
