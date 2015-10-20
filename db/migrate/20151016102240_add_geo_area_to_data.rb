class AddGeoAreaToData < ActiveRecord::Migration
  def change
  		add_column :data, :geo_area_id, :integer
  end
end
