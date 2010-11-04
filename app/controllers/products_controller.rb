class ProductsController < ApplicationController
  inherit_resources

  def current
    render :layout => "front"
  end
end
