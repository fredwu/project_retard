class PagesController < ApplicationController
  def show
    @heading = params[:id].titleize
    render params[:id]
  end
end
