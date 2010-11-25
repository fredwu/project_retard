class CartItem < ActiveRecord::Base
  include Datamappify::Resource

  acts_as_shopping_cart_item_for :cart

  property :cart_id,    :integer
  property :cart_type,  :string
  property :item_id,    :integer
  property :item_type,  :string
  property :quantity,   :integer
  property :price,      :decimal, :precision => 6, :scale => 2, :default => 0
  property :timestamps

  add_index [:cart_id, :cart_type]
  add_index :product_id

  belongs_to :product
  belongs_to :cart # dummy association for eager loading

  before_create  :attach_product_id
  after_create   :stock_down
  before_destroy :stock_up
  after_save     :calculate_shipping_cost_for_the_cart

  def item_specs
    case item_type
    when "ProductItem"
      "#{item.colour.name} / #{item.size.name}"
    when "ProductVoucher"
      "Voucher"
    end
  end

  private

  def attach_product_id
    self.product_id = ProductItem.find(item_id).product.id
  end

  def stock_down
    item.stock -= quantity
    item.save
  end

  def stock_up
    item.stock += quantity
    item.save
  end

  def calculate_shipping_cost_for_the_cart
    if item.product.shipping_au.to_i > cart.shipping_cost.to_i
      cart.update_attribute :shipping_cost, item.product.shipping_au
    end
  end
end
