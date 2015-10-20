class AddRegionIdToData < ActiveRecord::Migration
  def change
  	add_column :data, :region_id, :integer
  end
end
