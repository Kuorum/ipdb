class ChangeGeoAreaIdToRegionId < ActiveRecord::Migration
  def change
  	rename_column :political_parties, :geo_area_id, :region_id
  end
end
