class Size < ActiveRecord::Base
  include Datamappify::Resource

  property :name, :string
  property :timestamps

  add_index :name

  validates_presence_of :name

  has_many :products, :through => :product_items

  default_scope order(:name)
end
