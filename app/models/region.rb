class Region < ActiveRecord::Base

	def iso_and_name    
    	"#{self.iso3166_2} --- " " #{self.name.titleize }"   
  	end

end
