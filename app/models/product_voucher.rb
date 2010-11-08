class ProductVoucher < ActiveRecord::Base
  include Datamappify::Resource

  property :code, :string, :limit => 20
  property :limit, :integer, :limit => 4, :default => 0

  add_index :product_id
  add_index [:product_id, :code]

  belongs_to :product

  validates_presence_of     :product_id
  validates_numericality_of :limit, :greater_than_or_equal_to => 0

  default_scope joins(:product.outer).order(:product_id.desc, :code)
end
