require 'date'

user1 = User.create!(
  username: 'user1',
  email: 'user1@example.com',
  password: 'password1',
  password_confirmation: 'password1',
  phone_number: '90000001'
)

user1.create_user_particular!(
  full_name: 'Rohingya Aung', 
  phone_number: '111-222-3333',
  secondary_phone_number: '555-555-5555',
  country_of_origin: 'Myanmar',
  ethnicity: 'Rohingya',
  religion: 'Muslim',
  gender: 'Male',
  date_of_birth: Date.new(1990, 3, 25),
  date_of_arrival: Date.new(2017, 9, 10),
  photo_url: 'https://example.com/rohingya_aung_photo.jpg',
  birth_certificate_url: 'https://example.com/rohingya_aung_birth_certificate.jpg',
  passport_url: 'https://example.com/rohingya_aung_passport.jpg'
)

user2 = User.create!(
  username: 'user2',
  email: 'user2@example.com',
  password: 'password2',
  password_confirmation: 'password2',
  phone_number: '90000002'
)

#User particular: no secondary phone number
user2.create_user_particular!(
  full_name: 'Fatima Ali', 
    phone_number: '444-555-6666',
    country_of_origin: 'Iraq',
    ethnicity: 'Kurdish',
    religion: 'Muslim',
    gender: 'Female',
    date_of_birth: Date.new(1985, 12, 18),
    date_of_arrival: Date.new(2010, 5, 20),
    photo_url: 'https://example.com/fatima_ali_photo.jpg',
    birth_certificate_url: 'https://example.com/fatima_ali_birth_certificate.jpg',
    passport_url: 'https://example.com/fatima_ali_passport.jpg'
)

user3 = User.create!(
  username: 'user3',
  email: 'user3@example.com',
  password: 'password3',
  password_confirmation: 'password3',
  phone_number: '90000003'
)

#User particular: no birth_certificate_url and passport_url
user3.create_user_particular!(
  full_name: 'Ahmed Khalid', 
  phone_number: '777-888-9999',
  secondary_phone_number: '555-555-5555',
  country_of_origin: 'Syria',
  ethnicity: 'Arab',
  religion: 'Muslim',
  gender: 'Male',
  date_of_birth: Date.new(1992, 7, 3),
  date_of_arrival: Date.new(2015, 2, 10),
  photo_url: 'https://example.com/ahmed_khalid_photo.jpg',
)

user4 = User.create!(
  username: 'user4',
  email: 'user4@example.com',
  password: 'password4',
  password_confirmation: 'password4',
  phone_number: '90000004'
)

user4.create_user_particular!(
  full_name: 'Phyu Phyu Win', 
  phone_number: '123-456-7890',
  secondary_phone_number: '555-123-4567',
  country_of_origin: 'Myanmar',
  ethnicity: 'Burmese',
  religion: 'Buddhist',
  gender: 'Female',
  date_of_birth: Date.new(1988, 5, 12),
  date_of_arrival: Date.new(2012, 8, 15),
  photo_url: 'https://example.com/phyu_phyu_win_photo.jpg',
  birth_certificate_url: 'https://example.com/phyu_phyu_win_birth_certificate.jpg',
  passport_url: 'https://example.com/phyu_phyu_win_passport.jpg'
)

user5 = User.create!(
  username: 'user5',
  email: 'user5@example.com',
  password: 'password5',
  password_confirmation: 'password5',
  phone_number: '90000005'
)

user5.create_user_particular!(
  full_name: 'Hussein Abbas', 
  phone_number: '555-666-7777',
  secondary_phone_number: '010-814-4567',
  country_of_origin: 'Iraq',
  ethnicity: 'Arab',
  religion: 'Muslim',
  gender: 'Male',
  date_of_birth: Date.new(1995, 10, 7),
  date_of_arrival: Date.new(2018, 4, 22),
  photo_url: 'https://example.com/hussein_abbas_photo.jpg',
  birth_certificate_url: 'https://example.com/hussein_abbas_birth_certificate.jpg',
  passport_url: 'https://example.com/hussein_abbas_passport.jpg'
)

