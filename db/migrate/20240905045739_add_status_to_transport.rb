class AddStatusToTransport < ActiveRecord::Migration[7.2]
  def change
    add_column :transports, :status, :string
  end
end
