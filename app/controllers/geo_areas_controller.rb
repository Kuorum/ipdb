class GeoAreasController < ApplicationController
  before_action :set_geo_area, only: [:show, :edit, :update, :destroy]

  # GET /geo_areas
  # GET /geo_areas.json
  def index
    @geo_areas = GeoArea.all
  end

  # GET /geo_areas/1
  # GET /geo_areas/1.json
  def show
  end

  # GET /geo_areas/new
  def new
    @geo_area = GeoArea.new
  end

  # GET /geo_areas/1/edit
  def edit
  end

  # POST /geo_areas
  # POST /geo_areas.json
  def create
    @geo_area = GeoArea.new(geo_area_params)

    respond_to do |format|
      if @geo_area.save
        format.html { redirect_to @geo_area, notice: 'Geo area was successfully created.' }
        format.json { render :show, status: :created, location: @geo_area }
      else
        format.html { render :new }
        format.json { render json: @geo_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /geo_areas/1
  # PATCH/PUT /geo_areas/1.json
  def update
    respond_to do |format|
      if @geo_area.update(geo_area_params)
        format.html { redirect_to @geo_area, notice: 'Geo area was successfully updated.' }
        format.json { render :show, status: :ok, location: @geo_area }
      else
        format.html { render :edit }
        format.json { render json: @geo_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geo_areas/1
  # DELETE /geo_areas/1.json
  def destroy
    @geo_area.destroy
    respond_to do |format|
      format.html { redirect_to geo_areas_url, notice: 'Geo area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geo_area
      @geo_area = GeoArea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def geo_area_params
      params.require(:geo_area).permit(:name, :code, :category, :parent_id)
    end
end
