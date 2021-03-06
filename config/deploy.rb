$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"

# Quick Reference
# Configure the essential configurations below and do the following:
#
#   For more information:
#   http://github.com/meskyanichi/deployer
#
#   Create Local and Remote Repository:
#   This will create a git repository on the deployment server
#   Will not work when using a remote location such as github.com, trunksapp.com
#     git init
#     cap deploy:repository:create
#
#   Initial Deployment:
#     git add .
#     git commit -m "Initial commit for deployment"
#     git push origin [:branch]
#     cap deploy:initial
#
#   Then For Every Update Just Do:
#     git add .
#     git commit -am "some other commit"
#     git push origin [:branch]
#     cap deploy
#
#   For a Full List of Commands
#     cap -T


##
# Essential Configuration
# Assumes Application and Git Repository are located on the same server
set :appname,   "shop.2threads.com"     # the name of your application
set :ip,        "111.118.174.9"   # the ip address of the production server
set :user,      "deployer"        # the user that will deploy to the production server
set :remote,    "origin"          # the remote that should be deployed
set :branch,    "master"      # the branch that should be deployed


##
# Optional
# Specify custom deployment path

set :deploy_path, "/var/www"


##
# Optional
# If you want to use a repository from a different location (github.com, trunksapp.com, etc)
# Then you can specify the URL here. When using this, the "cap deploy:repository" tasks won't work.

set :repository_url, "git@github.com:fredwu/shop.2threads.com.git"


##
# Optional
# Use this to define a list of files you want to upload for the deploy:initial task

# set :sync_files,
#   %w(config/mongoid.yml)


##
# Optional
# Use this to skip database deployment tasks (db:create, db:migrate)
# Useful when, for example, not using ActiveRecord, but MongoDB with Mongoid instead

set :skip_database, true


##
# Optional
# It is recommended to use `require "bundler/capistrano"` for installing gems
# However you can comment out the line and enable `:enable_custom_bundler` to run your own `bundle install`

# Caution: please only enable one of the options below!
# set :enable_custom_bundler, true
require "bundler/capistrano"


##
# Optional
# Set options for bundle install
# Can speed up deployment by skipping the bundle install on test and development gems

set :bundle_options, "--path /var/www/shared/bundle --deployment --quiet --without development test"


##
# Optional
# Set bundler path (if in a nonstandard place)

# set :bundle_path, "/usr/local/bin/bundle"


##
# Optional
# Set up additional shared folders. The example below will create:
# SHARED_PATH/public/system
# SHARED_PATH/public/assets
# SHARED_PATH/db

set :additional_shared_folders,
  %w(public/system public/assets public/uploads public/product_images public/retailer_logos)


##
# Optional
# Set up additional shared symlinks
# These are mirrored to the Rails Applications' structure
# public/system         = RAILS_ROOT/public/system          => SHARED_PATH/public/system
# public/assets         = RAILS_ROOT/public/assets          => SHARED_PATH/public/assets
# db/production.sqlite3 = RAILS_ROOT/db/production.sqlite3  => SHARED_PATH/db/production.sqlite3

set :additional_shared_symlinks,
  %w(public/system public/assets public/uploads public/product_images public/retailer_logos)


##
# Optional
# Additional Application Specific Tasks and Callbacks
# In here you can specify which Application Specific tasks you would like to run right before
# Passenger restarts the application. You invoke the by simply calling "run_custom_task"
# For a list of all the available tasks that you could add to this "after_deploy" method, run: cap -T
def after_deploy
  run_custom_task "copy_db_config"
  run_custom_task "remove_cached_assets"
end

##
# Application Specific Deployment Tasks
# In here you may specify any application specific and/or other tasks that are not handled by Deployer
# These can be invoked by creating a "run_custom_task" method in the "after_deploy" method above
namespace :deploy do
  desc "Copies production database config"
  task :copy_db_config, :roles => :web do
    run "cp #{current_release}/config/database.production.yml #{current_release}/config/database.yml"
  end

  desc "Removes cached JavaScript and CSS asset files"
  task :remove_cached_assets, :roles => :web do
    run "cd #{current_release} && rake cache:assets:clear RAILS_ENV=production"
  end
end