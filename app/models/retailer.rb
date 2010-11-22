class Retailer < ActiveRecord::Base
  include Datamappify::Resource

  mount_uploader :logo, LogoUploader

  property :name, :string
  property :code, :string, :limit => 10
  property :website, :string
  property :contact_details, :text
  property :logo, :string
  property :timestamps

  add_index :name
  add_index :code

  validates_presence_of   :name
  validates_presence_of   :code
  # validates_presence_of   :logo
  validates_uniqueness_of :code
  validates_format_of     :code, :with => /^[a-zA-Z0-9_]*$/, :message => "can only contain alphanumeric and underscore characters"

  has_many :products
  has_many :orders
  has_many :users

  default_scope order(:name)
end
