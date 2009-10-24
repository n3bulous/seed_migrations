require 'seed_migrations'

backport = Rails::VERSION::MAJOR <= 2 && Rails::VERSION::MINOR <= 3 && Rails::VERSION::TINY < 4

namespace :db do
  namespace :seed_migrations do
    desc <<-EOS
      Merge an existing seeds.rb file into the seed_migrations setup.
    EOS

    task :init => :environment do
      migrate_existing_seeds_file if File.exists?(SEEDS_FILE_TARGET)

      File.copy SEEDS_FILE_SOURCE, SEEDS_FILE_TARGET
    end

    def migrate_existing_seeds_file
      seed_order_exists = File.exists?(SEED_INDEX)
      seed_order_used = File.size(SEED_INDEX > 0)

      FileUtils.mv SEEDS_FILE_TARGET, PREEXISTING_SEEDS_COPY

      filename_for_seed_order = File.basename(PREEXISTING_SEEDS_COPY, ".rb")
      if seed_order_exists && seed_order_used
        seed_order = YAML.load_File(SEED_INDEX)
        seed_order << filename_for_seed_order
      elsif seed_order_exists
        seed_order = [filename_for_seed_order]
      end

      File.open(SEED_INDEX, 'w') do |out|
        YAML.dump(seed_order, out)
      end
    end
  end

  if backport
    desc <<-EOS
      Loads seed data from <RAILS_ROOT>/db/seeds.rb.
    EOS

    task :seed => :environment do
      seed_file = File.join(RAILS_ROOT, "db", "seeds.rb")

      load(seed_file) if File.exists?(seed_file)
    end
  end
end
