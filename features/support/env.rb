# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'cucumber/rails'

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
<<<<<<< HEAD
  raise "You need to add database_cleaner-active_record to your Gemfile (in the :test group) if you wish to use it."
=======
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
>>>>>>> development
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
# Use truncation strategy for scenarios tagged with @no-txn, @selenium, @culerity, @celerity, or @javascript.
# Truncation is often necessary for scenarios involving JavaScript.
Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
  # { except: [:widgets] } may not do what you expect here
  # as Cucumber::Rails::Database.javascript_strategy overrides
  # this setting.
  DatabaseCleaner.strategy = :truncation
end

# Use transaction strategy for all other scenarios.
Before('not @no-txn', 'not @selenium', 'not @culerity', 'not @celerity', 'not @javascript') do
  DatabaseCleaner.strategy = :transaction
end

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation
<<<<<<< HEAD

# Run pending migrations before each scenario
Before do
  ActiveRecord::Migrator.migrations_paths = [File.expand_path('../../db/migrate', __FILE__)]
  ActiveRecord::Migration.maintain_test_schema!

  # Check for pending migrations
  begin
    ActiveRecord::Migration.check_pending!
  rescue ActiveRecord::PendingMigrationError
    ActiveRecord::Migrator.migrate(File.join(Rails.root, 'db/migrate'))
  end
end

# Ensure the database is clean before each scenario
Before do
  DatabaseCleaner.start
end

After do |scenario|
  DatabaseCleaner.clean
end
=======
# For FactoryBot, creating user in the test database
World(FactoryBot::Syntax::Methods)
>>>>>>> development
