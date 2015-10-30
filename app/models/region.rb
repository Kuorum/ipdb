class Region < ActiveRecord::Base
	has_many :political_parties

	def iso_and_name    
    	"#{self.iso3166_2} --- " " #{self.name.titleize } (#{self.id})"   
  	end

  	def iso_and_id    
    	"#{self.iso3166_2}-#{self.id }"   
  	end


end
