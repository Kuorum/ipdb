class ProcessController < ApplicationController

  def download_csv()
    
    region_id = params[:region_id]
    @datum = Datum.where(:region_id => region_id)


    csv_string = CSV.generate do |csv|
         csv << Datum.column_names

         @datum.each do |data|
           csv << data.attributes.values_at(*Datum.column_names)
         end
    end         
  
   send_data csv_string,
   :type => 'text/csv; charset=iso-8859-1; header=present',
   :disposition => "attachment; filename=politicians.csv" 

  end  

  def scrape
    
    region_id = params[:region_id]
    region_row = Region.find(region_id)
    region_code = region_row.iso3166_2 

    region_file_name = region_code.gsub("-", "_")
    
    scrape_script = 'scraper_' +  region_file_name
    scrape_update_script = 'scraper_update_' +  region_file_name

    
    country = Country.where(:region => region_id)
    country.each do |c|
      if (c.scraped == true)
        puts "running update script..."
        %x[rake #{scrape_update_script}]
      else
        puts "running scrape script..."
        %x[rake #{scrape_script}]
      end
    end  
    
    redirect_to root_url
  
  end 

end

