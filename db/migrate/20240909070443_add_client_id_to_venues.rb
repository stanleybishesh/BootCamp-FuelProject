class AddClientIdToVenues < ActiveRecord::Migration[7.2]
  def change
    add_column :venues, :client_id, :integer
    add_index :venues, :client_id
  end
end
