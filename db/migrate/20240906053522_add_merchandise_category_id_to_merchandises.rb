class AddMerchandiseCategoryIdToMerchandises < ActiveRecord::Migration[7.2]
  def change
    add_column :merchandises, :merchandise_category_id, :integer
    add_index :merchandises, :merchandise_category_id
  end
end
