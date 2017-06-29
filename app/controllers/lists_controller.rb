class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /lists
  # GET /lists.json
  def index
    if current_user && User.find(current_user.id)
      @user  = User.find(params[:user_id])
      @lists = @user.lists
    else
      flash[:alert] = "You must sign in before you can access lists!"
      redirect_to new_user_session_path
    end
  end

  # GET /lists/1
  def show
    if current_user && User.find(current_user.id)
      return
    else
      flash[:alert] = "You must sign in before you can access lists!"
      redirect_to new_user_session_path
    end
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    if current_user && User.find(current_user.id) 
      #@list = List.new(list_params)
      #@list.user = current_user
      @list = current_user.lists.new(list_params)
      if @list.save
        flash[:notice] = 'List was successfully created.'
        redirect_to user_list_path(@list, user_id: @list.user.id) 
      else
        render :new
      end
    else
      flash[:alert] = 'You must sign in before you can access lists!'
      redirect_to new_user_session_path
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to user_list_path(@list, user_id: @list.user.id), notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to user_lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.fetch(:list, {}).permit(:user_id, :name, :active)
    end
end
