class SeedGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.directory 'db/seeds'
      m.file 'seed_order.yaml.example', "db/seeds/seed_order.yaml", :collision => :skip

      timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
      base_name = "#{timestamp}_#{name.underscore}"
      
      m.file 'seed_data.rb.example', "db/seeds/#{base_name}.rb"

      m.gsub_file('db/seeds/seed_order.yaml', /^(.*)$/m) do |match|
        "#{match}- #{base_name}\n"
      end

    end
  end
end
