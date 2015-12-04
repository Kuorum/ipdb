class PermissionsController < ApplicationController
  before_action :set_permission, only: [:show, :edit, :edit2, :update, :destroy]
  before_filter :require_permission

  # GET /permissions
  # GET /permissions.json
  def index
    @permissions = Permission.all
  end

  # GET /permissions/1
  # GET /permissions/1.json
  def show
  end

  # GET /permissions/new
  def new
    @permission = Permission.new
  end

  # GET /permissions/1/edit
  def edit
  end

  # GET /permissions/1/edit
  def edit2

  end

  # POST /permissions
  # POST /permissions.json
  def create
    region_ids = params[:region_ids]

    #region_ids.each { |id| puts id }
   

    @permission = Permission.new(permission_params.merge(:permission => region_ids))

    respond_to do |format|
      if @permission.save
        format.html { redirect_to @permission, notice: 'Permission was successfully created.' }
        format.json { render :show, status: :created, location: @permission }
      else
        format.html { render :new }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permissions/1
  # PATCH/PUT /permissions/1.json
  def update
    respond_to do |format|
      region_ids = params[:region_ids]

      if @permission.update(permission_params.merge(:permission => region_ids))
        format.html { redirect_to @permission, notice: 'Permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @permission }
      else
        format.html { render :edit }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  def update2
    respond_to do |format|
      region_ids = params[:region_ids]

      if @permission.update(permission_params.merge(:permission => region_ids))
        format.html { redirect_to @permission, notice: 'Permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @permission }
      else
        format.html { render :edit }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.json
  def destroy
    @permission.destroy
    respond_to do |format|
      format.html { redirect_to permissions_url, notice: 'Permission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permission
      @permission = Permission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permission_params
      params.require(:permission).permit(:user_id, :permission)
    end

    def require_permission
      if current_user.role_id != 1
        redirect_to root_path
      end 
    end 
end
