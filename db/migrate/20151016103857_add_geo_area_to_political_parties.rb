class AddGeoAreaToPoliticalParties < ActiveRecord::Migration
  def change
  	add_column :political_parties, :geo_area_id, :integer
  end
end
