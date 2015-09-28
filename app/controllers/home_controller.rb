class HomeController < ApplicationController
  before_action :authenticate_user!
 
  def index
 	@countries = Country.all
  end

  def scrape
  	
  	@country = Country.find_by_abbreviation(params[:region])
  	
  	scrape_script = 'scrape_' +  params[:region]
  	scrape_update_script = 'scrape_update_' +  params[:region] 

  	if (@country.scraped == true)
  	  %x[rake #{scrape_update_script}]
	else
	  %x[rake #{scrape_script}]
	end
	  
  	redirect_to root_url
  
  end	

  def show
  	@datum = Datum.where(region: params[:region])
  end	

  def edit
  	@datum = Datum.where(region: params[:region])
  end	

end
