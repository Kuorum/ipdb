class DataController < ApplicationController
  before_action :authenticate_user!
  before_action :set_datum, only: [:show, :edit, :update, :destroy]

  # GET /data
  # GET /data.json
  def index
    @data = Datum.all
    @datum = Datum.all

    respond_to do |format|
      format.html
      format.csv { send_data @datum.to_csv }
    end  
  end

  def download
    @datum = Datum.where(region: params[:region])
    
    respond_to do |format|
      format.html
      format.csv { send_data @datum.to_csv }
    end  
  end 

  # GET /data/1
  # GET /data/1.json
  def show
  end

  # GET /data/new
  def new
    @datum = Datum.new
  end

  # GET /data/1/edit
  def edit
  end

  # POST /data
  # POST /data.json
  def create
    @datum = Datum.new(datum_params)

    respond_to do |format|
      if @datum.save
        format.html { redirect_to @datum, notice: 'Datum was successfully created.' }
        format.json { render :show, status: :created, location: @datum }
      else
        format.html { render :new }
        format.json { render json: @datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data/1
  # PATCH/PUT /data/1.json
  def update
    respond_to do |format|
      if @datum.update(datum_params)
        format.html { redirect_to @datum, notice: 'Datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @datum }
      else
        format.html { render :edit }
        format.json { render json: @datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data/1
  # DELETE /data/1.json
  def destroy
    @datum.destroy
    respond_to do |format|
      format.html { redirect_to data_url, notice: 'Datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datum
      @datum = Datum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datum_params
      params.require(:datum).permit(:sourceWebsite, :name, :picture, :politicalParty, :politicalPartyImage, :verified, :likes, :followers, :email, :twitter, :facebook, :linkedin, :googlePlus, :instagram, :blog, :youtubeChannel, :premium, :bio, :quote1, :quote2, :sourceActivity, :lastActivity1, :lastActivity2, :lastActivity3, :lastActivity4, :ideology1, :ideology2, :ideology3, :ideology4, :ideology5, :following, :openProjects, :closedProjects, :proposals, :debates, :sponsorships, :victories, :dateOfBirth, :placeOfBirth, :institutionalAddress, :institutionalTelephone, :institutionalFax, :institutionalMobilePhone, :electoralAddress, :electoralTelephone, :electoralFax, :electoralMobile, :phone, :assistants, :completeName, :position, :region, :institution, :constituency, :studies, :university, :profession, :cvLink, :declarationLink, :officialWebsite)
    end
end
