class ProductImage < ActiveRecord::Base
  include Datamappify::Resource

  mount_uploader :file, ImageUploader

  property :file, :string

  add_index :product_id

  validates_presence_of :product_id
  # validates_presence_of :file

  belongs_to :product

  after_create :update_file_name

  private

  def update_file_name
    write_attribute :file, file.filename
    save :validate => false
  end
end
