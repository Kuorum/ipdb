class GeoAreaCategoriesController < ApplicationController
  before_action :set_geo_area_category, only: [:show, :edit, :update, :destroy]

  # GET /geo_area_categories
  # GET /geo_area_categories.json
  def index
    @geo_area_categories = GeoAreaCategory.all
  end

  # GET /geo_area_categories/1
  # GET /geo_area_categories/1.json
  def show
  end

  # GET /geo_area_categories/new
  def new
    @geo_area_category = GeoAreaCategory.new
  end

  # GET /geo_area_categories/1/edit
  def edit
  end

  # POST /geo_area_categories
  # POST /geo_area_categories.json
  def create
    @geo_area_category = GeoAreaCategory.new(geo_area_category_params)

    respond_to do |format|
      if @geo_area_category.save
        format.html { redirect_to @geo_area_category, notice: 'Geo area category was successfully created.' }
        format.json { render :show, status: :created, location: @geo_area_category }
      else
        format.html { render :new }
        format.json { render json: @geo_area_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /geo_area_categories/1
  # PATCH/PUT /geo_area_categories/1.json
  def update
    respond_to do |format|
      if @geo_area_category.update(geo_area_category_params)
        format.html { redirect_to @geo_area_category, notice: 'Geo area category was successfully updated.' }
        format.json { render :show, status: :ok, location: @geo_area_category }
      else
        format.html { render :edit }
        format.json { render json: @geo_area_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geo_area_categories/1
  # DELETE /geo_area_categories/1.json
  def destroy
    @geo_area_category.destroy
    respond_to do |format|
      format.html { redirect_to geo_area_categories_url, notice: 'Geo area category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geo_area_category
      @geo_area_category = GeoAreaCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def geo_area_category_params
      params.require(:geo_area_category).permit(:name)
    end
end
