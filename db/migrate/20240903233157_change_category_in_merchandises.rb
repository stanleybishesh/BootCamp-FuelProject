class ChangeCategoryInMerchandises < ActiveRecord::Migration[7.2]
  def up
    # If you have existing data in the column, you'll want to handle converting it
    # You might want to add some logic here to convert string values to integers
    change_column :merchandises, :category, :integer, using: 'category::integer'
  end

  def down
    # If you need to rollback, this will convert the integer back to string
    change_column :merchandises, :category, :string
  end
end
