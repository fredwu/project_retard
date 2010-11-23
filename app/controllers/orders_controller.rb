class OrdersController < AdminController
  inherit_resources

  def add_to_cart
    e! unless request.post?

    if params[:product_item].blank? && params[:product_voucher].blank?
      redirect_to :back, :alert => "Please choose a colour and size" and return
    end

    find_or_create_cart
    add_item_to_cart

    redirect_to :action => :cart
  end

  def cart
    find_cart

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

  def find_cart
    @cart = Cart.find(session[:cart_id])
  end

  def find_or_create_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  def add_item_to_cart
    item = params[:product_item].present? ? ProductItem.find(params[:product_item]) : ProductVoucher.find(params[:product_voucher])
    @cart.add(item, item.product.price)
  end
end
