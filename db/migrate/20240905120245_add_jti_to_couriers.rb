class AddJtiToCouriers < ActiveRecord::Migration[7.2]
  def change
    add_column :couriers, :jti, :string
    add_index :couriers, :jti
  end
end
