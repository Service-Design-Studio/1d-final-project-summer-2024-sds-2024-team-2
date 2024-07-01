# check_migrations.rb
require './config/environment'

ActiveRecord::Base.connection.execute("SELECT * FROM schema_migrations").each { |row| puts row }
