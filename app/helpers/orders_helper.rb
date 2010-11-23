module OrdersHelper
  def product_name(item)
    item.item_type.constantize.find(item.item_id).product.name
  end

  def product_specs(item)
    case item.item_type
    when "ProductItem"
      product_item(item)
    when "ProductVoucher"
      "Voucher"
    end
  end

  def product_item(item)
    product_item_line(ProductItem.find(item.item_id))
  end
end
