class SkuController < ApplicationController


  def find
    
    redirect_to sku_show_path(params[:search])
  end

  def show
    @sku = skroutz_client.skus.find(params[:id])
  end

end

