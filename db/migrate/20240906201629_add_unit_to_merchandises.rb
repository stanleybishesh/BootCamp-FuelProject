class AddUnitToMerchandises < ActiveRecord::Migration[7.2]
  def change
    add_column :merchandises, :unit, :string
  end
end
