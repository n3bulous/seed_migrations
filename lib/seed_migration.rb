$:.unshift(File.dirname(__FILE__))

require 'seed_migration/file'
require 'seed_migration/migration'
require 'seed_migration/seeding'

module SeedMigration
  
  def self.directory
    "#{Rails.root}/db/seeds"
  end
  
  def self.files
    paths = Dir["#{directory}/*.rb"].sort
    paths.map {|path| SeedMigration::File.new(path) }
  end
  
  def self.load
    files.each {|file| file.load }
  end
  
end