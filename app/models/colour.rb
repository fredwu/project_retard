class Colour < ActiveRecord::Base
  include Datamappify::Resource

  property :name, :string
  property :hex,   :string
  property :timestamps

  add_index :name
  add_index :hex

  validates_presence_of :name
  validates_presence_of :hex

  has_many :products, :through => :product_items

  default_scope order(:name)
end
