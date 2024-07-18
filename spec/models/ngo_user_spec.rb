require 'rails_helper'

RSpec.describe NgoUser, type: :model do
  # Rollback transaction after each test case
  around(:each) do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

  describe '.find_by_id' do
    it 'returns the ngo user with the correct attributes' do
      created_ngo_user = NgoUser.create!(name: "Test NGO", image_url: "test_ngo.png")

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

  describe '.search_by_name' do
    it 'returns the ngo user when given the full name' do
      # Create ngo user
      created_ngo_user = NgoUser.create!(name: "Test NGO", image_url: "test_ngo.png")

      attributes = { 
        name: "Test NGO",
        image_url: "test_ngo.png"
      }
    
      # Test the search_by_name method
      found_ngo_users = NgoUser.search_by_name("Test NGO")
      
      expect(found_ngo_users.size).to eq(1)
      found_ngo_user = found_ngo_users.first
      attributes.each do |key, value|
        expect(found_ngo_user.send(key)).to eq(value)
      end
    end

    it 'returns ngo users with names that partially match the search term' do
      # Create test ngo users 1 and 2
      created_ngo_user = NgoUser.create!(name: "Test NGO 1", image_url: "test_ngo_1.png")

      ngo_user_attributes_1 = { 
        name: "Test NGO 1",
        image_url: "test_ngo_1.png"
      }

      created_ngo_user = NgoUser.create!(name: "Test NGO 2", image_url: "test_ngo_2.png")

      ngo_user_attributes_2 = { 
        name: "Test NGO 2",
        image_url: "test_ngo_2.png"
      }
    
      # Test the search_by_name method
      found_ngo_users = NgoUser.search_by_name("Test NGO")
      
      expect(found_ngo_users.size).to eq(2)
      found_ngo_user_1 = found_ngo_users[0]
      ngo_user_attributes_1.each do |key, value|
        expect(found_ngo_user_1.send(key)).to eq(value)
      end

      found_ngo_user_2 = found_ngo_users[1]
      ngo_user_attributes_2.each do |key, value|
        expect(found_ngo_user_2.send(key)).to eq(value)
      end
    end
  end

  describe '.all_ngo_users' do
    it 'returns all seeded NGO users' do
      ngo_users_data = [
        { name: 'CARE International', image_url: 'care.png' },
        { name: 'Amnesty International', image_url: 'AmnestyInternational.png' },
        { name: 'Oxfam', image_url: 'oxfam.png' },
        { name: 'World Vision', image_url: 'worldvision.png' },
        { name: 'Human Rights Watch', image_url: 'humanrightswatch.png' }
      ]

      ngo_users_data.each do |ngo_data|
        NgoUser.find_or_create_by(name: ngo_data[:name]) do |ngo_user|
          ngo_user.image_url = ngo_data[:image_url]
        end
      end

      all_ngo_users = NgoUser.all_ngo_users

      expect(all_ngo_users.count).to eq(5) 
      expect(all_ngo_users.map(&:name)).to include(
        'CARE International', 'Amnesty International', 'Oxfam', 'World Vision', 'Human Rights Watch'
      )

      expect(all_ngo_users.map(&:image_url)).to include(
        'care.png', 'AmnestyInternational.png', 'oxfam.png', 'worldvision.png', 'humanrightswatch.png'
      )
    end
  end
end
