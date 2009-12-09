require File.dirname(__FILE__) + '/../test_helper'

class SeedMigration::FileTest < Test::Unit::TestCase
  
  context "An instance of the File class" do
    
    should "know the path" do
      file = SeedMigration::File.new('/path/to/1234_file.rb')
      file.path.should == '/path/to/1234_file.rb'
    end
    
    should "know its version" do
      file = SeedMigration::File.new('/path/to/1234_file.rb')
      file.version.should == '1234'
    end
    
    should "know its name" do
      file = SeedMigration::File.new('/path/to/1234_seed_file.rb')
      file.name.should == 'seed_file'
    end
    
    
    should "know that the file hasn't been loaded" do
      file = SeedMigration::File.new('')
      file.stubs(:version).with().returns('1')
      
      SeedMigration::Seeding.stubs(:find_by_version).with('1').returns(nil)
      
      file.loaded?.should be(false)
    end
    
    should "know that the file has been loaded" do
      file = SeedMigration::File.new('')
      file.stubs(:version).with().returns('1')
      
      SeedMigration::Seeding.stubs(:find_by_version).with('1').returns(stub())
      
      file.loaded?.should be(true)
    end
    
    should "be able to create the table" do
      file = SeedMigration::File.new('')
      SeedMigration::Migration.expects(:up).with()
      
      file.migrate
    end
    
  end
  
end