namespace :dev do
  namespace :uploads do
    namespace :images do
      desc "Removes uploaded images"
      task :clear => :environment do
        FileUtils.rm_rf Dir["public/product_images/"]
        FileUtils.rm_rf Dir["public/retailer_logos/"]
      end
    end
  end

  desc "Runs default dev tasks"
  task :default => :environment do
    Rake::Task["dev:uploads:images:clear"].invoke
    Rake::Task["db:dummy"].invoke
  end

  desc "Runs default dev tasks and updates the db schema"
  task :all => :environment do
    Rake::Task["db:schema:update"].invoke
    Rake::Task["dev:default"].invoke
  end
end

desc "Runs default dev tasks"
task :dev do
  Rake::Task["dev:default"].invoke
end