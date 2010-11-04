class ApplicationController < ActionController::Base
  protect_from_forgery
  layout lambda{ |c| c.request.xhr? ? false : "admin" }

  rescue_from ActionController::RoutingError do |exception|
    flash[:errormsg] = "The page you are trying to access does not exist."
    redirect_to root_url
  end if Rails.env.production?

  before_filter :pass_current_user_to_model

  def pass_current_user_to_model
    ActiveRecord::Base.send :cattr_accessor, :current_user
    ActiveRecord::Base.send :current_user=, current_user
  end
end
