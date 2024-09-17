class DeleteColumnTypeInMerchandise < ActiveRecord::Migration[7.2]
  def self.up
  remove_column :merchandises, :category
  end
end
