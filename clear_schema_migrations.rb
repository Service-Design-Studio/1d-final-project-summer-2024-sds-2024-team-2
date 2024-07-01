require './config/environment'

ActiveRecord::Base.connection.execute("DELETE FROM schema_migrations")
puts "schema_migrations table cleared."
