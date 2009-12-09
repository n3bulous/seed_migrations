if Rails::VERSION::STRING >= '2.3.4'
  Rake::Task['db:seed'].clear
end

namespace :db do
  
  task :seed => :environment do
    SeedMigration.load
  end
  
end
