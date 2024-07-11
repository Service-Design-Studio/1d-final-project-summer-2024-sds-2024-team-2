require 'rails_helper'

RSpec.describe UserParticular, type: :model do
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

  describe '.create' do
    it 'creates a new user particular' do
      new_user = User.new(username: 'newuser', email: 'newuser@mail.com', password: 'password6',
                             phone_number: '91234567')

      new_user_particular = new_user.build_user_particular(
        full_name: 'John Tan',
        phone_number_country_code: '+65',
        phone_number: '91234567',
        secondary_phone_number_country_code: '+60',
        secondary_phone_number: '900001314',
        full_phone_number: '6591234567',
        country_of_origin: 'Myanmar',
        ethnicity: 'Chinese',
        religion: 'Buddhism',
        gender: 'Male',
        date_of_birth: Date.new(2001, 11, 1),
        date_of_arrival: Date.new(2019, 10, 20),
        photo_url: 'https://example.com/john_tan_photo.jpg',
        birth_certificate_url: 'https://example.com/john_tan_birth_certificate.jpg',
        passport_url: 'https://example.com/john_tan_passport.jpg'
      )

      new_user.save!
      new_user_particular.save!
      
      expect(new_user_particular).to be_valid  # Ensure the instance is valid
     
      expect(new_user_particular).not_to be_nil

      attributes = {
        full_name: 'John Tan',
        phone_number_country_code: '+65',
        phone_number: '91234567',
        secondary_phone_number_country_code: '+60',
        secondary_phone_number: '900001314',
        full_phone_number: '6591234567',
        country_of_origin: 'Myanmar',
        ethnicity: 'Chinese',
        religion: 'Buddhism',
        gender: 'Male',
        date_of_birth: Date.new(2001, 11, 1),
        date_of_arrival: Date.new(2019, 10, 20),
        photo_url: 'https://example.com/john_tan_photo.jpg',
        birth_certificate_url: 'https://example.com/john_tan_birth_certificate.jpg',
        passport_url: 'https://example.com/john_tan_passport.jpg'
      }

      expect(new_user_particular).to have_attributes(attributes)
    end
  end

  describe '.find_by_id' do
    it 'returns the user particular with the specified ID' do
      attributes = { 
        full_name: 'Rohingya Aung',
        phone_number_country_code: '+60', 
        phone_number: '111-222-3333',
        secondary_phone_number_country_code: '+60',
        secondary_phone_number: '555-555-5555',
        full_phone_number: '60111-222-3333',
        country_of_origin: 'Myanmar',
        ethnicity: 'Rohingya',
        religion: 'Islam',
        gender: 'Male',
        date_of_birth: Date.new(1990, 3, 25),
        date_of_arrival: Date.new(2017, 9, 10),
        photo_url: 'https://example.com/rohingya_aung_photo.jpg',
        birth_certificate_url: 'https://example.com/rohingya_aung_birth_certificate.jpg',
        passport_url: 'https://example.com/rohingya_aung_passport.jpg'
      }
  
      # Find the first user particular to ensure it exists
      user_particular = UserParticular.first
      expect(user_particular).not_to be_nil
  
      # Test the find_by_id method
      found_user_particular = UserParticular.find_by_id(user_particular.id)
      expect(found_user_particular).not_to be_nil
      attributes.each do |key, value|
          expect(found_user_particular.send(key)).to eq(value)
      end
      
      #expect(found_user_particular.attributes.except('id', 'created_at', 'updated_at', 'date_of_birth', 'date_of_arrival').symbolize_keys).to eq(attributes)
    end  

    it 'returns nil if no user particular with the specified ID is found' do
      found_user_particular = UserParticular.find_by_id(999999) # Assuming there's no user particular with ID 999999
      expect(found_user_particular).to be_nil
    end
  end

  describe '.reset_verification' do
  it 'sets status as pending and verifier ngo to nil' do
    new_user = User.new(username: 'user6', email: 'user6@mail.com', password: 'password6',
                      phone_number: '90000006')

    new_user_particular = new_user.build_user_particular(
      full_name: 'Ashin Jinarakkhita',
      phone_number_country_code: '+60',
      phone_number: '03-21008141',
      secondary_phone_number_country_code: '+60',
      secondary_phone_number: '03-21348711',
      full_phone_number: '60555-666-7777',
      country_of_origin: 'Myanmar',
      ethnicity: 'Chinese',
      religion: 'Buddhism',
      gender: 'Female',
      date_of_birth: Date.new(1999, 11, 1),
      date_of_arrival: Date.new(2019, 10, 20),
      photo_url: 'https://example.com/ashin_jinarakkhita_photo.jpg',
      birth_certificate_url: 'https://example.com/ashin_jinarakkhita_birth_certificate.jpg',
      passport_url: 'https://example.com/ashin_jinarakkhita_passport.jpg',
      status: 'verified',
      verifier_ngo: 'Oxfam'
    )

    new_user.save!
    new_user_particular.save!

    expect(new_user_particular).to be_valid  # Ensure the instance is valid
    
    UserParticular.reset_verification(new_user_particular.id)
    
    found_user_particular = UserParticular.find_by_id(new_user_particular.id)
    expect(found_user_particular.status).to eq('pending')
    expect(found_user_particular.verifier_ngo).to be_nil
  end
end

end
