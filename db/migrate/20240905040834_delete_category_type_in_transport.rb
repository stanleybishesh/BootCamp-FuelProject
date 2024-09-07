class DeleteCategoryTypeInTransport < ActiveRecord::Migration[7.2]
  def self.up
    remove_column :transports, :category
  end
end
