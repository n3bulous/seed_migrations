module SeedMigration
  
  class File
    
    attr_reader :path
    
    def initialize(path)
      @path = path
    end
    
    def version
      split[1]
    end
    
    def name
      split[2]
    end
    
    def loaded?
      !Seeding.find_by_version(version).nil?
    end
    
    def migrate
      SeedMigration::Migration.up
    end
    
    def load
      migrate
      if !loaded?
        begin
          puts "Loaded data from #{path}"
          super path
          Seeding.create!(:version => version, :name => name)
        rescue => e
          puts "There was a problem loading data from #{path}"
          puts e.backtrace
        end
      end
    end
    
    private
    def filename
      ::File.basename(@path)
    end
    
    def split
      filename.match(/^(\d+)_(.*).rb$/)
    end
    
  end
  
end