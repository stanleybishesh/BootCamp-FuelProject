class CreateMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :memberships do |t|
      t.integer :tenant_id
      t.integer :client_id

      t.timestamps
    end
    add_index :memberships, :tenant_id
    add_index :memberships, :client_id
  end
end
