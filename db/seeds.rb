require 'seed_migrations'

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

CreateSeeding.up
seeds = YAML::load_file(SEED_INDEX) if File.exists?(SEED_INDEX)
seeds.each {|s| load_seed s}
