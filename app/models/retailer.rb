class Retailer < ActiveRecord::Base
  include Datamappify::Resource

  property :name, :string
  property :code, :string, :limit => 10
  property :info, :text
  property :timestamps

  add_index :name
  add_index :code

  validates_presence_of   :name
  validates_presence_of   :code
  validates_uniqueness_of :name
  validates_uniqueness_of :code

  has_many :products
  has_many :users

  default_scope order(:code)
end
