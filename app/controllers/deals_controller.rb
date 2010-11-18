class DealsController < ApplicationController
  def home
    if Product.running.count == 1
      @product ||= Product.running.last
      render "deals/one"
    else
      @products ||= Product.running
      render "deals/list"
    end
  end
end
