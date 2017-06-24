require 'net/http'

class SkuController < ApplicationController



  def find


    a = checkInputID(params[:search])

    if(a!=-1)
      redirect_to sku_show_path(a)
    else
      #redirect if the input isnt correct
      redirect_to root_path
    end

  end

  def show
        begin
            @sku = skroutz_client.skus.find(params[:id])
        rescue
          #Exception if the product doesnt exist
           redirect_to root_path
        end
    
  end


  private
   def checkInputID(searchParams)
    if (searchParams.include?"//www.skroutz.gr/")
      return getSkouId(searchParams)
    elsif (searchParams =~ /\A\d+\z/ ? true : false)
        return searchParams
    else
        return -1
    end
  end

  def getSkouId(link)
    return link[/(?<=\/(c|s)\/)\w+/]
  end


end
