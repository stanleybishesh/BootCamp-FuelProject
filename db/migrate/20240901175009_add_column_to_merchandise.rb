class AddColumnToMerchandise < ActiveRecord::Migration[7.2]
  def change
    add_column :merchandises, :tenant_id, :integer
    add_index :merchandises, :tenant_id
  end
end
