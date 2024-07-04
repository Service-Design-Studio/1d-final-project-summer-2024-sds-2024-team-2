FactoryBot.define do
  factory :user do
    username { 'testuser' }
    email { 'user@example.com' }
    password { 'password' }
    phone_number { '1234567890' }
    # Add other necessary attributes here
  end
end
