class AddColumnsToClients < ActiveRecord::Migration[7.2]
  def change
    add_column :clients, :email, :string
    add_column :clients, :address, :string
    add_column :clients, :phone, :string
  end
end
