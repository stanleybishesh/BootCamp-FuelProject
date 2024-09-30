class AddDeletedAtToClientsAndVenues < ActiveRecord::Migration[7.2]
  def change
    add_column :clients, :deleted_at, :datetime
    add_column :venues, :deleted_at, :datetime
  end
end
