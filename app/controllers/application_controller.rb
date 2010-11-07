class ApplicationController < ActionController::Base
  protect_from_forgery
  layout lambda{ |c| c.request.xhr? ? false : "admin" }

  rescue_from ActionController::RoutingError do |exception|
    flash[:errormsg] = "The page you are trying to access does not exist."
    redirect_to root_url
  end if Rails.env.production?

  before_filter :require_login
  before_filter :pass_current_user_to_model

  def require_login
    redirect_to new_user_session_url if current_user.nil? && ! %q{
      devise/sessions devise/passwords devise/registrations devise/confirmations
    }.include?(params[:controller])
  end

  def pass_current_user_to_model
    ActiveRecord::Base.send :cattr_accessor, :current_user
    ActiveRecord::Base.send :current_user=, current_user
  end

  def product_redirect
    redirect_to products_url
  end
end
