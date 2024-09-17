class CreateTransports < ActiveRecord::Migration[7.2]
  def change
    create_table :transports do |t|
      t.string :name
      t.integer :status
      t.string :type
      t.string :category
      t.integer :tenant_id

      t.timestamps
    end
    add_index :transports, :tenant_id
  end
end
