class ApplicationController < ActionController::Base
  protect_from_forgery
  layout lambda{ |c| c.request.xhr? ? false : "public" }

  rescue_from ActionController::RoutingError do |exception|
    flash[:errormsg] = "The page you are trying to access does not exist."
    redirect_to root_url
  end if Rails.env.production?

  rescue_from Shop2T::AccessDenied do |exception|
    flash[:errormsg] = exception.to_s
    redirect_to root_url
  end

  before_filter :pass_current_user_to_model
  before_filter :user_cart, :if => lambda { current_user }

  protected

  def e!(message = nil)
    raise Shop2T::AccessDenied.new(message)
  end

  def error_redirect_to(destination, message = "An error has occured, please try again later.")
    redirect_to destination, :alert => message
  end

  def product_redirect
    redirect_to products_url
  end

  def pass_current_user_to_model
    ActiveRecord::Base.send :cattr_accessor, :current_user
    ActiveRecord::Base.send :current_user=, current_user
  end

  def user_cart
    @cart = current_user.cart
  end
end
