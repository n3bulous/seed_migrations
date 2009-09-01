namespace :db do
  desc <<-EOS
    Loads seed data from <RAILS_ROOT>/db/seeds2.rb.
  EOS

  task :seed42 => :environment do
    seed_file = File.join(RAILS_ROOT, "db", "seeds42.rb")

    load(seed_file) if File.exists?(seed_file)
  end
end
