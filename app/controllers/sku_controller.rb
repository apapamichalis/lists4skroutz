require 'net/http'

class SkuController < ApplicationController




  def show
        
        begin
            @sku = skroutz_client.skus.find(find(params[:search]))
        rescue
          #Exception if the product doesnt exist
           redirect_to root_path
        end
    
  end

  


  

end
