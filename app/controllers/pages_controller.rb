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

	    permission
	end

	
    def permission  
		region_id = params[:region_id] 

		has_access = 0

		permission = Permission.where(:user_id => current_user.id)
		permission.each do |p|
		regions =  eval(p.permission)
			regions.each do |region|

			  if current_user.role_id == 2 || current_user.role_id == 3 || current_user.role_id == 4
			    if region == region_id.to_s  
			      has_access = 1
			    end  
			  end

			end  
		end

		if current_user.role_id == 1
		has_access = 1
		end  

		if has_access == 0
		redirect_to root_path
		end  
    end


end	