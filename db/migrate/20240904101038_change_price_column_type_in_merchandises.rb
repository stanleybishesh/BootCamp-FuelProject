class ChangePriceColumnTypeInMerchandises < ActiveRecord::Migration[7.2]
  def up
    change_column :merchandises, :price, :float
  end

  def down
    change_column :merchandises, :price, :decimal
  end
end
