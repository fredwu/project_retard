class ProductVouchersController < AdminController
  inherit_resources

  def create
    create! do |success, failure|
      success.html { redirect_to collection_url }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to collection_url }
    end
  end

  protected

  def collection
    @product_vouchers ||= end_of_association_chain.paginate(
      :page     => params[:page],
      :per_page => Settings.collection.per_page
    )
  end
end
