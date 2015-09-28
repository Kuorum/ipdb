class AddScraperToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :scraper, :string
  end
end
