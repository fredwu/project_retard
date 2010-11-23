class Cart < ActiveRecord::Base
  include Datamappify::Resource

  acts_as_shopping_cart_using :cart_item
end
