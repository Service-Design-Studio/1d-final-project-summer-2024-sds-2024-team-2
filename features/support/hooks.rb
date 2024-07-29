Before do
  # Add your database reset logic here
  # For example, if you are using Rails, you can use:
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean
end
