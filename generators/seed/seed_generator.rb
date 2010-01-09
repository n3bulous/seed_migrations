class SeedGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.directory 'db/seeds'

      timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
      base_name = "#{timestamp}_#{name.underscore}"
      
      m.file 'seed_data.rb.example', "db/seeds/#{base_name}.rb"
    end
  end
end
