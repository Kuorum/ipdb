class Datum < ActiveRecord::Base

	def self.to_csv
		CSV.generate(headers: true) do |csv|
			csv << column_names
			all.each do |data|
				csv << data.attributes.values_at(*column_names)
			end	
		end	
	end	

end
