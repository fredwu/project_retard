class DealsController < ApplicationController
  def coming_soon
  end

  def home
    if Product.running.count == 1
      @product ||= Product.running.last
      render "deals/show"
    else
      @products ||= Product.running
      render "deals/list"
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
