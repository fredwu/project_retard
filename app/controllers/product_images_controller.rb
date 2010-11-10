class ProductImagesController < ApplicationController
  inherit_resources

  def create
    create! do |success, failure|
      success.html { redirect_to collection_url }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to collection_url }
    end
  end
end
