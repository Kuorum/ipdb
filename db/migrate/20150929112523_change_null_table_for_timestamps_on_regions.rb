class ChangeNullTableForTimestampsOnRegions < ActiveRecord::Migration
  def up
    change_column(:regions, :created_at, :datetime, :null => true)
    change_column(:regions, :updated_at, :datetime, :null => true)
  end

  def down
    change_column(:regions, :created_at, :datetime, :null => false)
    change_column(:regions, :updated_at, :datetime, :null => false)
  end
end
