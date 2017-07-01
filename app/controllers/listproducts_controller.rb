class ListproductsController < ApplicationController
  before_action :currentUserOwnsList, :userexists



  def create
    begin
            @sku = skroutz_client.skus.find(find(params[:search]))
    rescue
          #Exception if the product doesnt exist
           redirect_to root_path
    end

    @listproduct = Listproduct.new(list_id: params[:list_id],skuid: @sku.id)

    if @listproduct.save
      redirect_to edit_user_list_path(@list, user_id: current_user.id), notice: 'SKU added successfully.'
    else
      redirect_to edit_user_list_path(@list, user_id: current_user.id), warning: 'Failed to add SKU.'
    end
  end
    
  def destroy
    @listproduct = Listproduct.find_by(list_id: listproduct_params[:list_id], skuid: listproduct_params[:skuid])
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
    def currentUserOwnsList
      @list = List.find(params[:list_id])
      if @list.user == current_user
      
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def listproduct_params
      params.fetch(:listproduct, {}).permit(:list_id, :skuid)
    end
  

end

