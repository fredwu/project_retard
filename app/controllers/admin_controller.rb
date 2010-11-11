class AdminController < ApplicationController
  layout lambda{ |c| c.request.xhr? ? false : "admin" }

  before_filter :require_login

  def require_login
    redirect_to new_user_session_url if current_user.nil? && ! %q{
      devise/sessions devise/passwords devise/registrations devise/confirmations
    }.include?(params[:controller])
  end
end
