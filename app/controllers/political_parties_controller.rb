class PoliticalPartiesController < ApplicationController
  before_action :set_political_party, only: [:show, :edit, :update, :destroy]

  # GET /political_parties
  # GET /political_parties.json
  def index
    @political_parties = PoliticalParty.all
  end

  # GET /political_parties/1
  # GET /political_parties/1.json
  def show
  end

  # GET /political_parties/new
  def new
    @political_party = PoliticalParty.new
  end

  # GET /political_parties/1/edit
  def edit
  end

  # POST /political_parties
  # POST /political_parties.json
  def create
    @political_party = PoliticalParty.new(political_party_params)

    respond_to do |format|
      if @political_party.save
        format.html { redirect_to @political_party, notice: 'Political party was successfully created.' }
        format.json { render :show, status: :created, location: @political_party }
      else
        format.html { render :new }
        format.json { render json: @political_party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /political_parties/1
  # PATCH/PUT /political_parties/1.json
  def update
    respond_to do |format|
      if @political_party.update(political_party_params)
        format.html { redirect_to @political_party, notice: 'Political party was successfully updated.' }
        format.json { render :show, status: :ok, location: @political_party }
      else
        format.html { render :edit }
        format.json { render json: @political_party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /political_parties/1
  # DELETE /political_parties/1.json
  def destroy
    @political_party.destroy
    respond_to do |format|
      format.html { redirect_to political_parties_url, notice: 'Political party was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_political_party
      @political_party = PoliticalParty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def political_party_params
      params.require(:political_party).permit(:name, :leaning_index)
    end
end
