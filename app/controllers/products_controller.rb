class ProductsController < ApplicationController
  inherit_resources

  def current
    render :layout => "front"
  end

  def past
    render :layout => "front"
  end

  protected

  def collection
    @products ||= Product.list_order
  end
end
