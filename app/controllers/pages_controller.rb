class PagesController < ApplicationController

	def politicians
		#@datum = Datum.where(geo_area_id: params[:geo_area_id])
	end

	def parties
	end

	def alliance
		@region = Region.new
	end

	def nation
		@region = Region.new
	end

	def state
		@region = Region.new
	end

	def county
		@region = Region.new
	end

	def city
		@region = Region.new
	end

	def politicians
		@datum = Datum.where(region_id: params[:region_id])

	    region = Region.find(params[:region_id])
	    @region_name = region.name
	end


end	