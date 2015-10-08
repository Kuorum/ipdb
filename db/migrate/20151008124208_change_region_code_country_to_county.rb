class ChangeRegionCodeCountryToCounty < ActiveRecord::Migration
  def change
  	rename_column :data, :region_code_country, :region_code_county
  end
end
