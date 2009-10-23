class SeedGenerator < Rails::Generator::Base
  def manifest
    record do |m|

      m.directory File.join(RAILS_ROOT, "db/seeds")

      seed_order_file = File.join(RAILS_ROOT, "db/seeds/seed_order.yaml")
      FileUtils.touch seed_order_file unless File.exists?(seed_order_file)

      description = ARGV[-1]
      now = Time.now.utc.strftime "%Y%m%d%H%M%S"
      filename = "db/seeds/#{now}_#{description}.rb"

      FileUtils.touch File.join(RAILS_ROOT, filename)
      puts "Created #{filename}"

      base_file = File.basename(filename, '.rb')
      %x[echo "- #{base_file}" >> #{seed_order_file} ]
      puts "Appended #{base_file} to #{seed_order_file}"
    end
  end
end
