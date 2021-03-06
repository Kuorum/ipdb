class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :ban, :unban]
    before_filter :authenticate_user!
    before_filter :require_permission_all, only: [:index, :edit, :create, :destroy]
    before_filter :require_permission_show, only: [:show]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(current_user, :bypass => true)

        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def ban
    @user.status = 0
    
    if @user.save
      respond_to do |format|
        format.html { redirect_to :back , notice: 'User was successfully banned.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back , notice: 'Opps..something wrong!' }
        format.json { head :no_content }
      end
    end
  end

  def unban
    @user.status = 1
    
    if @user.save
      respond_to do |format|
        format.html { redirect_to :back , notice: 'User was successfully unbanned.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back , notice: 'Opps..something wrong!' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:full_name, :role_id, :email, :password, :supervisor)
    end

    def require_permission_show
      if current_user.role_id != 1 && current_user.role_id != 4
        redirect_to root_path
      end 
    end 

    def require_permission_all
      if current_user.role_id != 1 
        redirect_to root_path
      end 
    end 
end
