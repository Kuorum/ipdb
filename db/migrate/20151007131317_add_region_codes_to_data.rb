class AddRegionCodesToData < ActiveRecord::Migration
  def change
    add_column :data, :region_code_alliance, :string
    add_column :data, :region_code_nation, :string
    add_column :data, :region_code_state, :string
    add_column :data, :region_code_country, :string
    add_column :data, :region_code_city, :string
  end
end
