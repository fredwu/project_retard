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
    @products ||= end_of_association_chain.paginate(
      :page     => params[:page],
      :per_page => Settings.collection.per_page
    )
  end
end
