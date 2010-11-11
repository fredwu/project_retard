namespace :db do
  desc "Inserts dummy data"
  task :dummy => :environment do
    Rake::Task["db:setup"].invoke

    require File.dirname(__FILE__) + "/../../db/dummy"
  end
end