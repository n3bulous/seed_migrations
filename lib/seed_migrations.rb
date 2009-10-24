SEED_DIR = File.join(RAILS_ROOT, "db", "seeds")
SEED_INDEX = File.join(SEED_DIR, 'seed_order.yaml')
SEEDS_FILE_TARGET = File.join(RAILS_ROOT, "db", "seeds.rb")
SEEDS_FILE_SOURCE = File.join(File.dirname(__FILE__), "db/seeds.rb")
PREEXISTING_SEEDS_COPY = File.join(SEED_DIR, 'initial_seeds.rb')
