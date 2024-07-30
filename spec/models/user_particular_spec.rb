require 'rails_helper'

RSpec.describe UserParticular, type: :model do
  # Create new user and user particular for testing
  before(:all) do
    @user = User.find_or_create_by!(username: 'newuser') do |user|
      user.email = 'newuser@mail.com'
      user.password = 'password'
      user.phone_number = '91234567'
    end
    
    @attributes = {
      user_id: @user.id,
      full_name: 'John Tan',
      phone_number_country_code: '+65',
      phone_number: '91234567',
      secondary_phone_number_country_code: '+60',
      secondary_phone_number: '900001314',
      full_phone_number: '6591234567',
      country_of_origin: 'Myanmar',
      ethnicity: 'Abgal',
      religion: 'Buddhism',
      gender: 'Male',
      date_of_birth: Date.new(2001, 11, 1),
      date_of_arrival: Date.new(2019, 10, 20),
      photo_url: 'https://example.com/john_tan_photo.jpg',
      birth_certificate_url: 'https://example.com/john_tan_birth_certificate.jpg',
      passport_url: 'https://example.com/john_tan_passport.jpg'
    }

    @user_particular = UserParticular.find_or_create_by!(user_id: @user.id) do |user_particular|
      @attributes.each do |key, value|
        user_particular[key] = value
      end
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
    end
  end

  # describe '.create' do
  #   it 'creates a new user particular' do
  #     new_user_particular = UserParticular.create(@attributes)
  
  #     expect(new_user_particular).to be_valid
  #     expect(new_user_particular).not_to be_nil
  #     expect(new_user_particular).to have_attributes(@attributes)
  #   end
  
  #   it 'fails to create a user particular without a user_id' do
  #     attributes = @attributes.merge(user_id: nil)
  #     new_user_particular = UserParticular.create(attributes)
  
  #     expect(new_user_particular).not_to be_valid
  #   end
  
  #   it 'fails to create a user particular with a non-existent user_id' do
  #     attributes = @attributes.merge(user_id: 99999)  # Assuming 99999 is not a valid user ID
  #     new_user_particular = UserParticular.create(attributes)
  
  #     expect(new_user_particular).not_to be_valid
  #   end
  # end
  

  # describe '.find_by_id' do
  #   it 'returns the user particular with the specified ID' do
  #     # Test the find_by_id method
  #     found_user_particular = UserParticular.find_by_id(@user_particular.id)
  #     expect(found_user_particular).not_to be_nil
  #     @attributes.each do |key, value|
  #         expect(found_user_particular.send(key)).to eq(value)
  #     end
  #   end  

  #   it 'returns nil if no user particular with the specified ID is found' do
  #     found_user_particular = UserParticular.find_by_id(999999) # Assuming there's no user particular with ID 999999
  #     expect(found_user_particular).to be_nil
  #   end
  # end

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
      unique_id = @user_particular.unique_id
      two_fa_passcode = @user_particular.two_fa_passcode
      found_user_particular = UserParticular.find_by_unique_id_and_two_fa_passcode(unique_id, two_fa_passcode)
    
      expect(found_user_particular).not_to be_nil  # Ensure the user particular is found
    
      # Verify that the found user particular has the expected attributes
      @attributes.each do |key, value|
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
    UserParticular.update_user_particular(@user_particular.id, status: 'verified', verifier_ngo: 'Red Cross')
    UserParticular.reset_verification(@user_particular.id)
    
    found_user_particular = UserParticular.find_by_id(@user_particular.id)
    expect(found_user_particular.status).to eq('pending')
    expect(found_user_particular.verifier_ngo).to be_nil
    end
  end
end
