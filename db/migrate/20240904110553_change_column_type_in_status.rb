class ChangeColumnTypeInStatus < ActiveRecord::Migration[7.2]
  def up
    change_column :merchandises, :status, :string
  end

  def down
    change_column :merchandises, :status, :integer
  end
end
