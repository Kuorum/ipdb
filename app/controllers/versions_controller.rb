class VersionsController < ApplicationController
	before_filter :require_permission

	def index
		@versions = Version.all
	end

	def show
		@version = Version.find(params[:id])

		@author = User.find(@version.whodunnit)
		@author_name = @author.full_name 

		@changes = @version.changeset
	end

	private
	    def require_permission  

	      has_access = 0
	      if current_user.role_id == 1 || current_user.role_id == 4  
	        has_access = 1
	      end  

	      if has_access == 0
	        redirect_to root_path
	      end  

	    end

end	