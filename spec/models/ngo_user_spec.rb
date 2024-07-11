require 'rails_helper'

RSpec.describe NgoUser, type: :model do
  # Seed the database before running any tests,
  # and roll back once all tests are finished
  before(:all) do
    ActiveRecord::Base.transaction do
      Rails.application.load_seed
      @seeded = true
    end
  end

  # Rollback transaction after each test case
  around(:each) do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

  # Rollback the seeding after all tests are done
  after(:all) do
    if @seeded
      ActiveRecord::Base.connection.execute('DELETE FROM user_particulars')
      ActiveRecord::Base.connection.execute('DELETE FROM users')
      ActiveRecord::Base.connection.execute('DELETE FROM ngo_users')
    end
  end
end

require 'rails_helper'

RSpec.describe NgoUser, type: :model do
  describe '.find_by_id' do
    it 'returns the ngo user with the correct attributes' do
      created_ngo_user =NgoUser.create!(name: "Test NGO", image_url: "test_ngo.png")

      attributes = { 
        name: "Test NGO",
        image_url: "test_ngo.png"
      }
    
      # Test the find_by_id method
      found_ngo_user = NgoUser.find_by_id(created_ngo_user.id)
      expect(found_ngo_user).not_to be_nil
      attributes.each do |key, value|
        expect(found_ngo_user.send(key)).to eq(value)
      end
    end 
    
    it 'returns nil if no ngo user with the specified ID is found' do
      found_ngo_user = NgoUser.find_by_id(999999) # Assuming there's no ngo user with ID 999999
      expect(found_ngo_user).to be_nil
    end
  end
end
