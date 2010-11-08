class Product < ActiveRecord::Base
  include Datamappify::Resource
  include ActionView::Helpers::NumberHelper

  property :code,               :string,  :limit => 20
  property :name,               :string
  property :details,            :text
  property :shipping_info,      :text
  property :rrp,                :decimal, :precision => 6, :scale => 2, :default => 0
  property :price,              :decimal, :precision => 6, :scale => 2
  property :limit_per_customer, :integer, :limit => 2, :default => 0
  property :is_voucher,         :boolean, :default => false
  property :published_on,       :date
  property :timestamps

  add_index :name
  add_index :is_voucher

  validates_presence_of   :code
  validates_presence_of   :name
  validates_presence_of   :details
  validates_presence_of   :price
  validates_presence_of   :retailer_id
  validates_uniqueness_of :code
  validates_format_of     :code, :with => /^[a-zA-Z0-9_]*$/, :message => "can only contain alphanumeric and underscore characters"

  has_many :product_items
  has_many :product_vouchers
  has_many :colours, :through => :product_items
  has_many :sizes,   :through => :product_items
  belongs_to :retailer

  default_scope order("products.published_on IS NULL DESC", :published_on.desc)
  scope :list_order, includes(:product_items, :product_vouchers).order(
    { :product_items => :id, :product_vouchers => :id }, :updated_at.desc
  )
  scope :vouchers, where(:is_voucher => true)
  scope :items, where(:is_voucher => false)
  scope :published, where(:published_on => true)
  scope :unpublished, where(:published_on => false)

  def publish_on
    published_on
  end

  def is_voucher?
    is_voucher
  end

  def is_item?
    !is_voucher
  end

  def is_complete?
    product_items.any? || product_vouchers.any?
  end

  def is_incomplete?
    !is_complete?
  end

  def nice_price
    number_to_currency(price)
  end
end
