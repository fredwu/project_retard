class ProductVoucher < ActiveRecord::Base
  include Datamappify::Resource

  property :code, :string, :limit => 20
  property :stock, :integer, :limit => 5, :default => 0

  add_index :product_id
  add_index [:product_id, :code]

  belongs_to :product

  validates_presence_of     :product_id
  validates_presence_of     :code
  validates_numericality_of :stock, :greater_than_or_equal_to => 0

  default_scope includes(:product).order(:product_id.desc, :code)

  before_destroy :check_product_status
  before_update  :check_product_status

  def available
    stock > 0
  end

  private

  def check_product_status
    raise Shop2T::AccessDenied.new("The product associated is currently running or is ended.") if product.is_protected?
  end
end
