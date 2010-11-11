namespace :cache do
  namespace :assets do
    desc "Clears javascript and stylesheet cache"
    task :clear => :environment do
      FileUtils.rm Dir["public/javascripts/cached/*"]
      FileUtils.rm Dir["public/adminus/**/js/adminus.all.js"]
    end
  end
end
