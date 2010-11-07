class Colour < ActiveRecord::Base
  include Datamappify::Resource

  property :label, :string
  property :hex,   :string
  property :timestamps

  add_index [:product_item_id, :label, :hex]

  validates_presence_of :label
  validates_presence_of :hex

  belongs_to :product_item
end
