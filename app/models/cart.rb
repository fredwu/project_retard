class Cart < ActiveRecord::Base
  include Datamappify::Resource

  acts_as_shopping_cart_using :cart_item

  property :timestamps

  belongs_to :user

  before_create :attach_user_id, :if => proc { current_user }

  private

  def attach_user_id
    self.user_id = current_user.id
  end
end
