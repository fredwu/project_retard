class ProductItem < ActiveRecord::Base
  include Datamappify::Resource

  property :stock, :integer, :limit => 4, :default => 0
  property :voucher_code, :string, :limit => 20

  add_index :product_id
  add_index :colour_id
  add_index :size_id
  add_index [:product_id, :voucher_code, :colour_id, :size_id]

  belongs_to :product
  belongs_to :colour
  belongs_to :size

  validates_presence_of     :product_id
  validates_numericality_of :stock, :greater_than_or_equal_to => 0

  default_scope joins(:product.outer, :colour.outer, :size.outer).order(
    :product_id.desc, :voucher_code, :colour => :name, :size => :name
  )
end
