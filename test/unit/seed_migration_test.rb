require File.dirname(__FILE__) + '/../test_helper'

class SeedMigrationTest < Test::Unit::TestCase
  
  context "The SeedMigration module" do
    
    should "know the directory" do
      Rails.stubs(:root).with().returns(::Pathname.new('/rails'))
      SeedMigration.directory.should == '/rails/db/seeds'
    end
    
    should "be able to find all the seed files" do
      fs = setup_filesystem do |root|
        root.file '0123_first.rb'
        root.file '0124_second.rb'
        root.file 'ignored.txt'
      end
      
      SeedMigration.stubs(:directory).with().returns(fs.path)
      
      SeedMigration::File.stubs(:new).with("#{fs.path}/0123_first.rb").returns('file_1')
      SeedMigration::File.stubs(:new).with("#{fs.path}/0124_second.rb").returns('file_2')
      
      SeedMigration.files.should == %w(file_1 file_2)
      
      fs.destroy!
    end
    
  end
  
end