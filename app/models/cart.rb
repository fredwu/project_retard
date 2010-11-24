class Cart < ActiveRecord::Base
  include Datamappify::Resource

  acts_as_shopping_cart_using :cart_item

  property :shipping_cost, :decimal, :precision => 5, :scale => 2, :default => 0
  property :timestamps

  belongs_to :user

  before_create :attach_user_id, :if => proc { current_user }

  def gst
    total / 11
  end

  private

  def attach_user_id
    self.user_id = current_user.id
  end
end
