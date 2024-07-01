# check_migrations.rb
require './config/environment'

migrations = ActiveRecord::Base.connection.execute("SELECT * FROM schema_migrations")
if migrations.any?
  migrations.each { |row| puts row }
else
  puts "No migrations found."
end
