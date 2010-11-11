class DealsController < ApplicationController
  def current
    @product ||= Product.current
  end
end
