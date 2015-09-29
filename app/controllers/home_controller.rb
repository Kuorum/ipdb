class HomeController < ApplicationController
  before_action :authenticate_user!
 
  def index
 	  @countries = Country.all
  end

  def scrape
  	
    region_id = params[:region]
    region_row = Region.find(region_id)
    region_code = region_row.iso3166_2 

    region_file_name = region_code.gsub("-", "_")
  	
  	scrape_script = 'scraper_' +  region_file_name
  	scrape_update_script = 'scraper_update_' +  region_file_name

    
    country = Country.find_by_region(region_id)
  	if (country.scraped == true)
  	  %x[rake #{scrape_update_script}]
	  else
	    %x[rake #{scrape_script}]
	  end
	  
  	redirect_to root_url
  
  end	

  def show
  	@datum = Datum.where(region: params[:region])

    region = Region.find(params[:region])
    @region_name = region.name

  end	

  def edit
  	@datum = Datum.where(region: params[:region])
  end	

end
