Shop2T::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false
  config.cache_store                       = :dalli_store

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method       = :test
  config.action_mailer.default_url_options   = { :host => 'shop2t.local' }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # config.after_initialize do
  #   Bullet.enable                = false
  #   Bullet.disable_browser_cache = true
  #   Bullet.bullet_logger         = true
  #   Bullet.console               = true
  #   Bullet.rails_logger          = false
  #   Bullet.growl                 = false
  #   Bullet.alert                 = false
  #   Bullet.xmpp                  = false
  # end

  Slim::Engine.set_default_options :pretty => true
end

