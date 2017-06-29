class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /lists
  # GET /lists.json
  def index
    if current_user
      @user  = User.find(params[:user_id])
      @lists = @user.lists
    else
      flash[:alert] = "You must sign in before you can access lists!"
      redirect_to new_user_session_path
    end
  end

  # GET /lists/1
  def show
    if current_user
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
    if current_user
      redirect_to root_path and return unless @list.user == current_user
      return
    else
      flash[:alert] = "You must sign in before you can access lists!"
      redirect_to new_user_session_path
    end
  end

  # POST /lists
  # POST /lists.json
  def create
    if current_user
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
    if current_user 
      redirect_to root_path and return unless @list.user == current_user
      if @list.update(list_params)
        redirect_to user_list_path(@list, user_id: @list.user.id), notice: 'List was successfully updated.' 
      else
        render :edit      
      end
    else
      flash[:alert] = 'You must sign in before you can access lists!'
      redirect_to new_user_session_path
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    if current_user
      redirect_to root_path and return unless @list.user == current_user
      @list.destroy
      flash[:notice] = 'List was successfully destroyed.' 
      redirect_to user_lists_url 
    else
      flash[:alert] = 'You must sign in before you can access lists!'
      redirect_to new_user_session_path
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
