class ChangeColumnTypeInTransport < ActiveRecord::Migration[7.2]
  def self.up
    remove_column :transports, :status, :integer
  end

  def self.down
    add_column :transports, :status, :string
  end
end
