require 'rails_helper'

RSpec.describe UserParticular, type: :model do
  # Create new user and user particular for testing
  before(:all) do
    @user = User.create!(username: 'newuser', email: 'newuser@mail.com', password: 'password', phone_number: '91234567')
    
    @attributes = {
      user_id: @user.id,
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

    @user_particular = UserParticular.create_user_particular(@attributes)
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
    end
  end

  describe '.create' do
    it 'creates a new user particular' do
      # Create new user and corresponding user particular 
      new_user = User.create!(username: 'jason101', email: 'jason101@mail.com', password: 'password',
                             phone_number: '9004124')
  
      attributes = {
        user_id: new_user.id,
        full_name: 'Jason Tan',
        phone_number_country_code: '+65',
        phone_number: '9004124',
        secondary_phone_number_country_code: '+60',
        secondary_phone_number: '9004124',
        full_phone_number: '659004124',
        country_of_origin: 'Indonesia',
        ethnicity: 'Chinese',
        religion: 'Christianity',
        gender: 'Male',
        date_of_birth: Date.new(2001, 11, 1),
        date_of_arrival: Date.new(2019, 10, 20),
        photo_url: 'https://example.com/jason_tan_photo.jpg',
        birth_certificate_url: 'https://example.com/jason_tan_birth_certificate.jpg',
        passport_url: 'https://example.com/jason_tan_passport.jpg'
      }

      new_user_particular = UserParticular.create_user_particular(attributes)
      
      expect(new_user_particular).to be_valid  # Ensure the instance is valid
      expect(new_user_particular).not_to be_nil
      expect(new_user_particular).to have_attributes(attributes)
    end
  end

  describe '.find_by_id' do
    it 'returns the user particular with the specified ID' do
      # Test the find_by_id method
      found_user_particular = UserParticular.find_by_id(@user_particular.id)
      expect(found_user_particular).not_to be_nil
      @attributes.each do |key, value|
          expect(found_user_particular.send(key)).to eq(value)
      end
    end  

    it 'returns nil if no user particular with the specified ID is found' do
      found_user_particular = UserParticular.find_by_id(999999) # Assuming there's no user particular with ID 999999
      expect(found_user_particular).to be_nil
    end
  end

  describe '.find_by_unique_id' do
    it 'returns the user particular with the specified unique ID' do
      unique_id = @user_particular.unique_id
      found_user_particular = UserParticular.find_by_unique_id(unique_id)
    
      expect(found_user_particular).not_to be_nil  # Ensure the user particular is found
    
      # Verify that the found user particular has the expected attributes
      @attributes.each do |key, value|
        expect(found_user_particular.send(key)).to eq(value)
      end
    end

    it 'returns nil if no user particular with the specified ID is found' do
      found_user_particular = UserParticular.find_by_unique_id(999999) # Assuming there's no user particular with ID 999999
      expect(found_user_particular).to be_nil
    end
  end

  describe '.find_by_unique_id_and_two_fa_passcode' do
    it 'returns the user particular with the specified unique ID and two_fa_passcode' do
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
    
      # Create a new user and user particular
      new_user = User.new(username: 'newuser', email: 'newuser@mail.com', password: 'password',
                          phone_number: '91234567')
      
      new_user_particular = new_user.build_user_particular(attributes)
    
      new_user.save!
      new_user_particular.save!
    
      expect(new_user_particular).to be_valid  # Ensure the instance is valid
    
      unique_id = new_user_particular.unique_id
      two_fa_passcode = new_user_particular.two_fa_passcode
      found_user_particular = UserParticular.find_by_unique_id_and_two_fa_passcode(unique_id, two_fa_passcode)
    
      expect(found_user_particular).not_to be_nil  # Ensure the user particular is found
    
      # Verify that the found user particular has the expected attributes
      attributes.each do |key, value|
        expect(found_user_particular.send(key)).to eq(value)
      end
    end

    it 'returns nil if no user particular with the specified unique ID and two fa passcode is found' do
      # Assuming there's no user particular with unique ID 999999 and two fa passcode 999999
      found_user_particular = UserParticular.find_by_unique_id_and_two_fa_passcode(999999, 999999) 
      expect(found_user_particular).to be_nil
    end
  end

  describe '.reset_verification' do
  it 'sets status as pending and verifier ngo to nil' do
    new_user = User.new(username: 'user6', email: 'user6@mail.com', password: 'password',
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
