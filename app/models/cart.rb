class Cart < ActiveRecord::Base
  include Datamappify::Resource

  acts_as_shopping_cart_using :cart_item

  property :first_name,    :string, :limit => 50
  property :last_name,     :string, :limit => 50
  property :address,       :text
  property :city,          :string, :limit => 20
  property :state,         :string, :limit => 20
  property :postcode,      :string, :limit => 10
  property :country,       :string, :limit => 50
  property :shipping_cost, :decimal, :precision => 5, :scale => 2, :default => 0
  property :timestamps

  validates_presence_of :first_name, :on => :update
  validates_presence_of :last_name,  :on => :update
  validates_presence_of :address,    :on => :update
  validates_presence_of :city,       :on => :update
  validates_presence_of :state,      :on => :update
  validates_presence_of :country,    :on => :update

  belongs_to :user

  before_create :attach_user_details, :if => lambda { current_user rescue nil }

  def gst
    total / 11
  end

  private

  def attach_user_details
    self.user_id    = current_user.id
    self.first_name = current_user.first_name
    self.last_name  = current_user.last_name
  end
end
