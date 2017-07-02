class ListproductsController < ApplicationController
  before_action :currentUserOwnsList, :userexists
  before_action :authenticate_user!

  def create

    begin

      @sku = skroutz_client.skus.find(find(params[:search]))
      @listproduct = Listproduct.new(list_id: params[:list_id],skuid: @sku.id)
      if @listproduct.save
        redirect_to edit_user_list_path(@list, user_id: current_user.id), notice: 'SKU added successfully.'
      else
        redirect_to edit_user_list_path(@list, user_id: current_user.id), warning: 'Failed to add SKU.'
      end
    rescue
      #Exception if the product doesnt exist
      redirect_to edit_user_list_path(@list, user_id: current_user.id), notice: 'Failed to add SKU.'
    end
   
  end
    
  def destroy
    @listproduct = Listproduct.find_by(list_id: params[:list_id], skuid: params[:search])
    redirect_to root_path and return unless @listproduct.list.user == current_user
    if @listproduct.destroy
      redirect_to edit_user_list_path(@list, user_id: current_user.id), notice: 'SKU removed successfully.'
    else
      redirect_to edit_user_list_path(@list, user_id: current_user.id), warning: 'Failed to remove SKU.'
    end
  end

  private
    def userexists
      if current_user && User.find_by(id: current_user.id)
      end
    end
    def currentUserOwnsList
      @list = List.find(params[:list_id])
      if @list.user == current_user
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def listproduct_params
      params.fetch(:listproduct, {}).permit(:list_id, :skuid, :search)
    end
end