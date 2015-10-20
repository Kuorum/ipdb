class Region < ActiveRecord::Base
	has_many :political_parties

	def iso_and_name    
    	"#{self.iso3166_2} --- " " #{self.name.titleize }"   
  	end

end
