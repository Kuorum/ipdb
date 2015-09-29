class ChangeCountryAbbreviationToRegion < ActiveRecord::Migration
  def change
  	rename_column :countries, :abbreviation, :region
  end
end
