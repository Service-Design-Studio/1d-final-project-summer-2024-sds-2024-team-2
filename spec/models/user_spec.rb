require 'rails_helper'

RSpec.describe User, type: :model do
  # Rollback transaction after each test case
  around(:each) do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
  
  it 'is valid with valid attributes' do
    user = User.new(username: 'testuser', email: 'test@example.com', phone_number: '11111111',
    password: 'testpassword', password_confirmation: 'testpassword')
    expect(user).to be_valid  # Checks if the user is valid
  end

  it 'is not valid with empty username' do
    user = User.new(username: '', email: 'test@example.com', phone_number: '11111111',
    password: 'testpassword', password_confirmation: 'testpassword')
    expect(user).to_not be_valid  # Checks if the user is not valid
  end

  it 'is not valid with empty email' do
    user = User.new(username: 'testuser', email: '', phone_number: '11111111',
    password: 'testpassword', password_confirmation: 'testpassword')
    expect(user).to_not be_valid  # Checks if the user is valid
  end

  it 'is not valid with empty phone number' do
    user = User.new(username: 'testuser', email: 'test@example.com', phone_number: '',
    password: 'testpassword', password_confirmation: 'testpassword')
    expect(user).to_not be_valid  # Checks if the user is valid
  end

  it 'is not valid with empty passwords' do
    user = User.new(username: 'testuser', email: 'test@example.com', phone_number: '11111111',
    password: '', password_confirmation: '')
    expect(user).to_not be_valid  # Checks if the user is not valid
  end

  it 'is not valid with a duplicate username' do
    User.create(username: 'testuser1', email: 'test1@example.com', phone_number: '22222222',
    password: 'testpassword', password_confirmation: 'testpassword')
    user = User.new(username: 'testuser1', email: 'test2@example.com', phone_number: '3333333',
    password: 'testpassword', password_confirmation: 'testpassword')
    expect(user).to_not be_valid 
  end

  it 'is not valid with a duplicate email' do
    User.create(username: 'testuser1', email: 'test1@example.com', phone_number: '33333333',
    password: 'testpassword', password_confirmation: 'testpassword')
    user = User.new(username: 'testuser2', email: 'test1@example.com', phone_number: '44444444',
    password: 'testpassword', password_confirmation: 'testpassword')
    expect(user).to_not be_valid 
  end

  it 'is not valid with a duplicate phone number' do
    User.create(username: 'testuser1', email: 'test1@example.com', phone_number: '55555555',
    password: 'testpassword', password_confirmation: 'testpassword')
    user = User.new(username: 'testuser2', email: 'test1@example.com', phone_number: '55555555',
    password: 'testpassword', password_confirmation: 'testpassword')
    expect(user).to_not be_valid 
  end
end
