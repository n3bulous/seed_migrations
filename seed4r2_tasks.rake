namespace :db do
  desc <<-EOS
    Loads seed data from <RAILS_ROOT>/db/seeds4r2.rb.
  EOS

  task :seed4r2 => :environment do
    seed_file = File.join(RAILS_ROOT, "db", "seeds4r2.rb")

    load(seed_file) if File.exists?(seed_file)
  end
end
