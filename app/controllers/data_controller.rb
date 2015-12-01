class DataController < ApplicationController
  before_action :set_datum, only: [:show, :edit, :update, :destroy]
  before_filter :require_permission, only: [:new, :edit, :update, :destroy]

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

    @region =  Region.find(@datum.region_id)
    @region_name =  @region.name

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
    @datum = Datum.new(datum_params.merge(:region_id => params[:datum][:region_id]))

    respond_to do |format|
      if @datum.save
        format.html { redirect_to page_politicians_path(:region_id => params[:datum][:region_id]), notice: 'Politician was successfully added.' }
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

        format.html { redirect_to @datum, notice: 'Politician details was successfully updated.' }
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
      params.require(:datum).permit(:cause6, :sourceWebsite, :name, :picture, :politicalParty, :politicalPartyImage, :verified, :likes, :followers, :email, :twitter, :facebook, :linkedin, :googlePlus, :instagram, :pinterest, :blog, :youtubeChannel, :premium, :bio, :quote1, :quote2, :sourceActivity, :lastActivity1Date, :lastActivity2Date, :lastActivity3Date, :lastActivity4Date, :lastActivity5Date, :lastActivity1, :lastActivity2, :lastActivity3, :lastActivity4, :lastActivity5, :lastActivity1Action, :lastActivity2Action, :lastActivity3Action, :lastActivity4Action, :lastActivity5Action, :lastActivity1Outcome, :lastActivity2Outcome, :lastActivity3Outcome, :lastActivity4Outcome, :lastActivity5Outcome, :lastActivity1Link, :lastActivity2Link, :lastActivity3Link, :lastActivity4Link, :lastActivity5Link, :political_leaning_index, :ideology1, :ideology2, :ideology3, :ideology4, :ideology5, :following, :openProjects, :closedProjects, :proposals, :debates, :sponsorships, :victories, :dateOfBirth, :placeOfBirth, :institutionalAddress, :institutionalTelephone, :institutionalFax, :institutionalMobilePhone, :electoralAddress, :electoralTelephone, :electoralFax, :electoralMobile, :phone, :assistants, :completeName, :position, :region, :institution, :constituency, :studies,  :school, :university, :profession, :cvLink, :declarationLink, :officialWebsite, :political_experience1,  :political_experience2,  :political_experience3,  :political_experience4,  :political_experience5, :political_experience1_content, :political_experience2_content, :political_experience3_content, :political_experience4_content, :political_experience5_content, :political_experience1_date, :political_experience2_date, :political_experience3_date, :political_experience4_date, :political_experience5_date, :causes, :cause1, :cause2, :cause3, :cause4, :cause5, :region_code_alliance, :region_code_nation, :region_code_state, :region_code_county, :region_code_city, :constituency_code_alliance, :constituency_code_nation, :constituency_code_state, :constituency_code_country, :constituency_code_city, :known_for1, :known_for2, :known_for3, :known_for4, :known_for5, :known_for_link1, :known_for_link2, :known_for_link3, :known_for_link4, :known_for_link5)
    end

    def require_permission  
      @region_id = @datum.region_id

      has_access = 0

      permission = Permission.where(:user_id => current_user.id)
      permission.each do |p|
        regions =  eval(p.permission)
        regions.each do |region|

          if current_user.role_id == 2 || current_user.role_id == 4 
            if region == @region_id.to_s 
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