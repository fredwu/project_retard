class ProductItem < ActiveRecord::Base
  include Datamappify::Resource

  add_index :product_id

  belongs_to :product
  belongs_to :colour
  belongs_to :size
end
