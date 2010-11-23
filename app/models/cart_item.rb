class CartItem < ActiveRecord::Base
  include Datamappify::Resource

  acts_as_shopping_cart_item_for :cart

  property :cart_id,   :integer
  property :cart_type, :string
  property :item_id,   :integer
  property :item_type, :string
  property :quantity,  :integer
  property :price,     :decimal, :precision => 6, :scale => 2, :default => 0

  add_index :cart_id
end
