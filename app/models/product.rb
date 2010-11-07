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
  property :timestamps

  add_index :name
  add_index :is_voucher

  validates_presence_of   :code
  validates_presence_of   :name
  validates_presence_of   :details
  validates_presence_of   :price
  validates_presence_of   :retailer_id
  validates_uniqueness_of :code

  belongs_to :retailer
  has_many :colours, :through => :product_items
  has_many :sizes, :through => :product_items
  has_many :product_items

  def is_voucher?
    is_voucher
  end

  def nice_price
    number_to_currency price
  end
end
