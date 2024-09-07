class RenameColumnNameInTransport < ActiveRecord::Migration[7.2]
  def change
    rename_column :transports, :type, :vehicle_type
  end
end
