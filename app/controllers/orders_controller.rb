class OrdersController < AdminController
  inherit_resources

  def add_to_cart
    e! unless request.post?

    if params[:product_item].blank? && params[:product_voucher].blank?
      redirect_to :back, :alert => "Please choose a colour and size" and return
    end

    find_or_create_cart!

    @item = params[:product_item].present? ? ProductItem.find(params[:product_item]) : ProductVoucher.find(params[:product_voucher])

    if item_over_purchase_limit?
      error_redirect_to :back, "You have hit the purchase limit for this product."
    else
      @cart.add(@item, @item.product.price, params[:quantity].to_i)
      redirect_to :action => :cart
    end
  end

  def remove_from_cart
    e! unless request.xhr?

    find_or_create_cart!
    # @cart.delete(CartItem.find(params[:id]).item)

    render :nothing => true
  end

  def cart
    find_or_create_cart!

    render :layout => "public"
  end

  protected

  def collection
    @orders ||= end_of_association_chain.paginate(
      :page     => params[:page],
      :per_page => Settings.collection.per_page
    )
  end

  private

  def find_or_create_cart!
    if session[:cart_id]
      @cart ||= Cart.find_or_create_by_id(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  def item_over_purchase_limit?
    @item.product.total_ordered_quantity_by_customer + params[:quantity].to_i > @item.product.limit_per_customer
  end
end
