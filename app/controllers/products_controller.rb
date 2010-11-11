class ProductsController < AdminController
  inherit_resources

  protected

  def collection
    @products ||= end_of_association_chain.paginate(
      :page     => params[:page],
      :per_page => Settings.collection.per_page
    )
  end
end
