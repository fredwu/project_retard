class ProductsController < ApplicationController
  inherit_resources
  
  def latest
    render :text => "Latest product"
  end
end
