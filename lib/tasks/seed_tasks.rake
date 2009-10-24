backport = Rails::VERSION::MAJOR <= 2 && Rails::VERSION::MINOR <= 3 && Rails::VERSION::TINY < 4

if backport
  namespace :db do
    desc <<-EOS
      Loads seed data from <RAILS_ROOT>/db/seeds.rb.
    EOS

    task :seed => :environment do
      seed_file = File.join(RAILS_ROOT, "db", "seeds.rb")

      load(seed_file) if File.exists?(seed_file)
    end
  end

end
