module SeedMigration
  
  class Migration < ActiveRecord::Migration
    
    def self.up
      unless table_exists?(:seedings)
        create_table :seedings, :id => false do |t|
          t.string :version, :null => false
          t.string :name, :null => false
        end
        
        add_index :seedings, :version, :unique => true
      end
    end 
    
  end
  
end