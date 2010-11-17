namespace :dev do
  namespace :uploads do
    namespace :images do
      desc "Removes uploaded images"
      task :clear => :environment do
        FileUtils.rm_rf Dir["public/product_images/"]
      end
    end
  end

  desc "Runs default dev tasks"
  task :all => :environment do
    Rake::Task["dev:uploads:images:clear"].invoke
    Rake::Task["db:dummy"].invoke
  end
end
