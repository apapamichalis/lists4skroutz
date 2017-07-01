class VisitorsController < ApplicationController
	def show_product
		  respond_to do |format|
		    format.html
		    format.js 
		  end
	end
end
