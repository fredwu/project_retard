class Order < ActiveRecord::Base
  include Datamappify::Resource

  property :first_name, :string, :limit => 50
  property :last_name,  :string, :limit => 50
  property :address,    :text
  property :city,       :string, :limit => 20
  property :postcode,   :string, :limit => 10
  property :state,      :string, :limit => 30
  property :country,    :string, :limit => 50
  property :subtotal,   :decimal, :precision => 8, :scale => 2
  property :use_credit, :decimal, :precision => 6, :scale => 2
  property :shipping,   :decimal, :precision => 6, :scale => 2
  property :total,      :decimal, :precision => 8, :scale => 2
  property :notes,      :text
  property :shipped_at, :datetime
  property :timestamps

  add_index :retailer_id

  has_and_belongs_to_many :products
  belongs_to :manager,  :class_name => :user
  belongs_to :retailer

  default_scope order(:created_at.desc)
end
