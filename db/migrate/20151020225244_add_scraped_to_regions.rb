class AddScrapedToRegions < ActiveRecord::Migration
  def change
  	 add_column :regions, :scraped,  :boolean, :default => false    
  end
end
