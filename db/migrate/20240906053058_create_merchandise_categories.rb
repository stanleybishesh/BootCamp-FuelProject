class CreateMerchandiseCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :merchandise_categories do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
