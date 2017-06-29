class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :list_owner!, except: [:index, :show, :create]

  # GET /users/1/lists
  def index
    @user  = User.find(params[:user_id])
    @lists = @user.lists
  end

  # GET /users/1/lists/1
  def show
  end

  # GET /users/1/lists/new
  def new
    @list = List.new
  end

  # GET /users/1/lists/1/edit
  def edit
      redirect_to root_path and return unless @list.user == current_user
  end

  # POST /users/1/lists
  def create
    @list = current_user.lists.new(list_params)
    if @list.save
      flash[:notice] = 'List was successfully created.'
      redirect_to user_list_path(@list, user_id: @list.user.id) 
    else
      render :new
    end
  end

  # PATCH/PUT users/1/lists/1
  def update
    redirect_to root_path and return unless @list.user == current_user
    if @list.update(list_params)
      redirect_to user_list_path(@list, user_id: @list.user.id), notice: 'List was successfully updated.' 
    else
      render :edit      
    end
  end

  # DELETE /users/1/lists/1
  def destroy
    redirect_to root_path and return unless @list.user == current_user
    @list.destroy
    flash[:notice] = 'List was successfully destroyed.' 
    redirect_to user_lists_url 
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

    def list_owner!
      unless @list.user == current_user
        redirect_to root_path, alert: 'You are not authorized to reach this list resource!'
      end
    end
end
