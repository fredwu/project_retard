class ProductItem < ActiveRecord::Base
  include Datamappify::Resource

  property :stock, :integer, :limit => 4, :default => 0

  add_index :product_id
  add_index :colour_id
  add_index :size_id
  add_index [:product_id, :colour_id, :size_id]

  belongs_to :product
  belongs_to :colour
  belongs_to :size

  validates_presence_of     :product_id
  validates_numericality_of :stock, :greater_than_or_equal_to => 0

  before_destroy :check_product_status

  default_scope includes(:product, :colour, :size).order(:product_id.desc, :colour_id, :size_id)

  def available
    stock > 0
  end

  private

  def check_product_status
    raise Shop2T::AccessDenied.new("The product associated is currently running or is ended.") if product.is_protected?
  end
end
