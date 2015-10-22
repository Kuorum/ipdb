class DeleteGeoAreaIdFromData < ActiveRecord::Migration
  def change
	remove_column :data, :geo_area_id
  end
end
