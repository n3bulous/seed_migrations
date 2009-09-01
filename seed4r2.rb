# Use Ruby/Rails code to control your
SEED_DIR = File.join(RAILS_ROOT, "db", "seeds")
SEED_INDEX = File.join(SEED_DIR, 'seed_order.yaml')

class CreateSeeding < ActiveRecord::Migration
  def self.up
    unless (table_exists?("seedings"))
      create_table :seedings do |t|
        t.string :name, :null => false
        t.timestamps
      end
      add_index("seedings", :name, :unique => true)
    end
  end
end

class Seeding < ActiveRecord::Base
end

def load_seed(seed_index)
  file = seed_index + ".rb"
  source = File.join(SEED_DIR, file)

  seed = Seeding.find_by_name(seed_index)
  if (seed.nil?)
    puts "- Loading data from #{source}"
    success = load source
    if (success)
      Seeding.create!(:name => seed_index)
    else
      puts "! An error occurred while processing #{source}"
    end
  end
end

seeds = YAML::load(seed_index) if File.exists?(SEED_INDEX)
seeds.each {|s| load_seed s}
