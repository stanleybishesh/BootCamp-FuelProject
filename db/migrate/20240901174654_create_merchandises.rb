class CreateMerchandises < ActiveRecord::Migration[7.2]
  def change
    create_table :merchandises do |t|
      t.string :name
      t.integer :status
      t.string :category
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
