class Size < ActiveRecord::Base
  include Datamappify::Resource

  property :label, :string
  property :timestamps

  add_index :label

  validates_presence_of :label

  has_many :products, :through => :product_items
end
