require 'rails_helper'

RSpec.describe User, type: :model do
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
      ActiveRecord::Base.connection.execute('DELETE FROM users')
    end
  end

  describe 'validations' do
    context 'with valid attributes' do
      it 'is valid' do
        user = User.new(username: 'testuser', email: 'test@example.com', phone_number: '11111111',
                        password: 'testpassword', password_confirmation: 'testpassword')
        expect(user).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is not valid with empty username' do
        user = User.new(username: '', email: 'test@example.com', phone_number: '11111111',
                        password: 'testpassword', password_confirmation: 'testpassword')
        expect(user).to_not be_valid
      end

      it 'is not valid with empty email' do
        user = User.new(username: 'testuser', email: '', phone_number: '11111111',
                        password: 'testpassword', password_confirmation: 'testpassword')
        expect(user).to_not be_valid
      end

      it 'is not valid with empty phone number' do
        user = User.new(username: 'testuser', email: 'test@example.com', phone_number: '',
                        password: 'testpassword', password_confirmation: 'testpassword')
        expect(user).to_not be_valid
      end

      it 'is not valid with empty passwords' do
        user = User.new(username: 'testuser', email: 'test@example.com', phone_number: '11111111',
                        password: '', password_confirmation: '')
        expect(user).to_not be_valid
      end
    end

    context 'with duplicate attributes' do
      before(:each) do
        User.create!(username: 'testuser1', email: 'test1@example.com', phone_number: '22222222',
                     password: 'testpassword', password_confirmation: 'testpassword')
      end

      it 'is not valid with a duplicate username' do
        user = User.new(username: 'testuser1', email: 'test2@example.com', phone_number: '33333333',
                        password: 'testpassword', password_confirmation: 'testpassword')
        expect(user).to_not be_valid
      end

      it 'is not valid with a duplicate email' do
        user = User.new(username: 'testuser2', email: 'test1@example.com', phone_number: '44444444',
                        password: 'testpassword', password_confirmation: 'testpassword')
        expect(user).to_not be_valid
      end

      it 'is not valid with a duplicate phone number' do
        user = User.new(username: 'testuser2', email: 'test1@example.com', phone_number: '55555555',
                        password: 'testpassword', password_confirmation: 'testpassword')
        expect(user).to_not be_valid
      end
    end
  end

  describe '.find_for_database_authentication' do
    let!(:user) { User.create!(username: 'dbuser', email: 'db@user.com', phone_number: '11111111', password: 'testpassword', password_confirmation: 'testpassword') }

    it 'finds user by username' do
      expect(User.find_for_database_authentication(login: 'dbuser')).to eq(user)
    end

    it 'finds user by email' do
      expect(User.find_for_database_authentication(login: 'db@user.com')).to eq(user)
    end

    it 'finds user by phone number' do
      expect(User.find_for_database_authentication(login: '11111111')).to eq(user)
    end

    it 'returns nil if no user is found' do
      expect(User.find_for_database_authentication(login: 'nonexistent')).to be_nil
    end
  end
end
