class Product < ActiveRecord::Base
  include Datamappify::Resource
  include ActionView::Helpers::DateHelper

  property :code,               :string,  :limit => 20
  property :name,               :string
  property :details,            :text
  property :highlights,         :text
  property :terms,              :text
  property :rrp,                :decimal, :precision => 6, :scale => 2, :default => 0
  property :price,              :decimal, :precision => 6, :scale => 2
  property :shipping_au,        :decimal, :precision => 5, :scale => 2, :default => 0
  property :shipping_int,       :decimal, :precision => 5, :scale => 2, :default => 0
  property :limit_per_customer, :integer, :limit => 2, :default => 0
  property :minimum_purchases,  :integer, :limit => 3, :default => 50
  property :is_activated,       :boolean, :default => false
  property :is_voucher,         :boolean, :default => false
  property :start_at,           :datetime
  property :end_at,             :datetime
  property :timestamps

  add_index :name
  add_index :is_voucher
  add_index :is_activated
  add_index [:is_voucher, :is_activated]
  add_index [:start_at, :end_at]
  add_index [:start_at, :end_at, :is_activated]

  validates_presence_of   :code
  validates_presence_of   :name
  validates_presence_of   :details
  validates_presence_of   :price
  validates_presence_of   :retailer_id
  validates_uniqueness_of :code
  validates_format_of     :code, :with => /^[a-zA-Z0-9_]*$/, :message => "can only contain alphanumeric and underscore characters"

  has_many :product_images,   :dependent => :destroy, :limit => 5
  has_many :product_items,    :dependent => :destroy
  has_many :product_vouchers, :dependent => :destroy
  has_many :colours,          :through   => :product_items
  has_many :sizes,            :through   => :product_items
  has_many :cart_items
  has_and_belongs_to_many :orders
  belongs_to :retailer

  before_destroy :check_destroyable
  before_save    :set_end_at

  default_scope order("products.start_at IS NULL DESC", :start_at.desc, :end_at.desc)
  scope :vouchers, where(:is_voucher => true)
  scope :items, where(:is_voucher => false)
  scope :activated, where(:is_activated => true).where(:end_at > Time.now)
  scope :running, activated.where(:start_at <= Time.now)
  scope :upcoming, activated.where(:start_at > Time.now)

  def is_protected?
    is_running? || is_ended?
  end

  def is_not_protected?
    !is_protected?
  end

  def is_running?
    is_activated? && start_at.present? && Time.now >= start_at && Time.now <= end_at
  end

  def is_ended?
    end_at.present? && Time.now > end_at
  end

  def is_activated?
    !!is_activated
  end

  def is_voucher?
    is_voucher
  end

  def is_item?
    !is_voucher
  end

  def is_ready?
    has_images? && has_items_or_vouchers?
  end

  def is_not_ready?
    !is_ready?
  end

  def has_images?
    product_images.any?
  end

  def has_items_or_vouchers?
    has_items? || has_vouchers?
  end

  def has_items?
    product_items.any?
  end

  def has_vouchers?
    product_vouchers.any?
  end

  def discount
    if rrp == 0
      "N/A"
    else
      "%.2f%" % ((price - rrp) / price * 100)
    end
  end

  def time_left
    "%s left" % distance_of_time_in_words(Time.now, end_at)
  end

  def total_purchases
    0
  end

  def total_ordered_quantity_by_customer
    cart_items.joins(:cart).where(:carts => { :user_id => current_user.id }).sum(:quantity)
  end

  private

  def set_end_at
    self.end_at = 24.hours.since(start_at) if end_at.nil? && start_at
  end

  def check_destroyable
    raise not_destroyable! if is_protected?
  end

  def not_destroyable!
    Shop2T::AccessDenied.new("Cannot destroy a product that is currently running or is already ended.")
  end
end
