require 'date'
require 'faker'
# Seed data for users and their particulars
# Seeding is now idempotent
users_data = [
  {
    username: 'user1',
    email: 'user1@mail.com',
    password: 'password1',
    phone_number: '90000001',
    particulars: {
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
      status: 'verified',
      photo_url: 'https://example.com/rohingya_aung_photo.jpg',
      birth_certificate_url: 'https://example.com/rohingya_aung_birth_certificate.jpg',
      passport_url: 'https://example.com/rohingya_aung_passport.jpg',
      verifier_ngo: 'Gebirah',
      unique_id: '1055290',
      two_fa_passcode: '606833'
    }
  },
  {
    username: 'user2',
    email: 'user2@mail.com',
    password: 'password2',
    phone_number: '90000002',
    particulars: {
      full_name: 'Fatima Ali',
      phone_number_country_code: '+60',
      phone_number: '444-555-6666',
      secondary_phone_number_country_code: '+60',
      secondary_phone_number: '111-222-333',
      full_phone_number: '60444-555-6666',
      country_of_origin: 'Iraq',
      ethnicity: 'Kurd',
      religion: 'Islam',
      gender: 'Female',
      status: 'pending',
      date_of_birth: Date.new(1985, 12, 18),
      date_of_arrival: Date.new(2010, 5, 20),
      photo_url: 'https://example.com/fatima_ali_photo.jpg',
      birth_certificate_url: 'https://example.com/fatima_ali_birth_certificate.jpg',
      passport_url: 'https://example.com/fatima_ali_passport.jpg'
    }
  },
  {
    username: 'user3',
    email: 'user3@mail.com',
    password: 'password3',
    phone_number: '90000003',
    particulars: {
      full_name: 'Ahmed Khalid',
      phone_number_country_code: '+60',
      phone_number: '777-888-9999',
      secondary_phone_number_country_code: '+60',
      secondary_phone_number: '555-555-5555',
      full_phone_number: '60777-888-9999',
      country_of_origin: 'Syrian Arab Republic',
      ethnicity: 'Arab',
      religion: 'Islam',
      gender: 'Male',
      status: 'pending',
      date_of_birth: Date.new(1992, 7, 3),
      date_of_arrival: Date.new(2015, 2, 10),
      photo_url: 'https://example.com/ahmed_khalid_photo.jpg'
    }
  },
  {
    username: 'user4',
    email: 'user4@mail.com',
    password: 'password4',
    phone_number: '90000004',
    particulars: {
      full_name: 'Phyu Phyu Win',
      phone_number_country_code: '+60',
      phone_number: '123-456-7890',
      secondary_phone_number_country_code: '+60',
      secondary_phone_number: '555-123-4567',
      full_phone_number: '60123-456-7890',
      country_of_origin: 'Myanmar',
      ethnicity: 'Rohingya',
      religion: 'Buddhism',
      gender: 'Female',
      status: 'pending',
      date_of_birth: Date.new(1988, 5, 12),
      date_of_arrival: Date.new(2012, 8, 15),
      photo_url: 'https://example.com/phyu_phyu_win_photo.jpg',
      birth_certificate_url: 'https://example.com/phyu_phyu_win_birth_certificate.jpg',
      passport_url: 'https://example.com/phyu_phyu_win_passport.jpg'
    }
  },
  {
    username: 'user5',
    email: 'user5@mail.com',
    password: 'password5',
    phone_number: '90000005',
    particulars: {
      full_name: 'Hussein Abbas',
      phone_number_country_code: '+60',
      phone_number: '555-666-7777',
      secondary_phone_number_country_code: '+60',
      secondary_phone_number: '010-814-4567',
      full_phone_number: '60555-666-7777',
      country_of_origin: 'Iraq',
      ethnicity: 'Arab',
      religion: 'Islam',
      gender: 'Male',
      status: 'pending',
      date_of_birth: Date.new(1995, 10, 7),
      date_of_arrival: Date.new(2018, 4, 22),
      photo_url: 'https://example.com/hussein_abbas_photo.jpg',
      birth_certificate_url: 'https://example.com/hussein_abbas_birth_certificate.jpg',
      passport_url: 'https://example.com/hussein_abbas_passport.jpg'
    }
  },
  {
    username: 'newuser',
    email: 'newuser@mail.com',
    password: 'newuserpassword',
    phone_number: '60001119',
    particulars: nil
  }
]

# Seed bulletin data
bulletin_data = [
  {
    title: 'Bulletin 1',
    date: DateTime.new(2024, 7, 1),
    location: 'Singapore',
    description: 'This is bulletin 1',
    ngo_name: 'Gebirah',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Bulletin 2',
    date: DateTime.new(2024, 7, 2),
    location: 'Malaysia',
    description: 'This is bulletin 2',
    ngo_name: 'World Vision',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Bulletin 3',
    date: DateTime.new(2024, 7, 3),
    location: 'Thailand',
    description: 'This is bulletin 3',
    ngo_name: 'Oxfam',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Bulletin 4',
    date: DateTime.new(2024, 6, 28),
    location: 'Indonesia',
    description: 'This is bulletin 4',
    ngo_name: 'Gebirah',
    saved: false,
    created_at: DateTime.now - 3,
    updated_at: DateTime.now - 3
  },
  {
    title: 'Bulletin 5',
    date: DateTime.new(2024, 6, 29),
    location: 'Philippines',
    description: 'This is bulletin 5',
    ngo_name: 'Amnesty International',
    saved: false,
    created_at: DateTime.now - 2,
    updated_at: DateTime.now - 2
  },
  {
    title: 'Bulletin 6',
    date: DateTime.new(2024, 6, 30),
    location: 'Vietnam',
    description: 'This is bulletin 6',
    ngo_name: 'Human Rights Watch',
    saved: false,
    created_at: DateTime.now - 1,
    updated_at: DateTime.now - 1
  },
  {
    title: 'Bulletin 7',
    date: DateTime.new(2024, 7, 4),
    location: 'Cambodia',
    description: 'This is bulletin 7',
    ngo_name: 'World Relief',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Bulletin 8',
    date: DateTime.new(2024, 7, 5),
    location: 'Laos',
    description: 'This is bulletin 8',
    ngo_name: 'UNHCR',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Bulletin 9',
    date: DateTime.new(2024, 7, 6),
    location: 'Myanmar',
    description: 'This is bulletin 9',
    ngo_name: 'Save the Children',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Bulletin 10',
    date: DateTime.new(2024, 7, 7),
    location: 'Bangladesh',
    description: 'This is bulletin 10',
    ngo_name: 'CARE International',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
]
# Seed NgoUser data
ngo_users_data = [
  { name: 'CARE International', image_url: 'care.png' },
  { name: 'Amnesty International', image_url: 'AmnestyInternational.png' },
  { name: 'Oxfam', image_url: 'oxfam.png' },
  { name: 'World Vision', image_url: 'worldvision.png' },
  { name: 'Human Rights Watch', image_url: 'humanrightswatch.png' },
  { name: 'Gebirah', image_url: 'Gebirah.png' },
  { name: 'International Rescue Committee (IRC)', image_url: 'IRC.png' },
  { name: 'Doctors Without Borders/Médecins Sans Frontières', image_url: 'MSF.png' },
  { name: 'Norwegian Refugee Council (NRC)', image_url: 'NRC.png' },
  { name: 'Save the Children', image_url: 'Savethechildren.png' },
  { name: 'UNHCR', image_url: 'unhcr.png' },
  { name: 'World Relief', image_url: 'world relief.png' }
]

# Create or update users and their particulars
users_data.each do |user_data|
  user = User.find_or_initialize_by(username: user_data[:username])

  # Only create user data
  if user.new_record?
    user.email = user_data[:email]
    user.password = user_data[:password] # TODO: Has error when updating password during deployment
    user.phone_number = user_data[:phone_number]
    user.save!
  end
  particulars_data = user_data[:particulars]
  if particulars_data.nil?
    puts 'nil'
  else
    # Create/modify user data
    user_particular = user.user_particular || user.build_user_particular
    user_particular.assign_attributes(particulars_data)
    user_particular.save!
  end
end

# Create or update NgoUsers
ngo_users_data.each do |ngo_data|
  ngo_user = NgoUser.find_or_initialize_by(name: ngo_data[:name])
  ngo_user.update!(image_url: ngo_data[:image_url])
end

# Create or update Bulletins
bulletin_data.each do |each_bulletin_data|
  bulletin = Bulletin.find_or_initialize_by(title: each_bulletin_data[:title])
  bulletin.update!(each_bulletin_data)
end

users_history = []
15.times do
  users_history << {
    activity_type: 'Event',
    activity_title: Faker::Lorem.words(number: rand(1..5)).join(' '),
    description: Faker::Lorem.words(number: rand(1..20)).join(' '),
    date: DateTime.now - rand(1..30),
    user_id: User.first.id
  }
end
puts users_history
# Ensure there is at least one UserParticular record
if User.first.nil?
  puts 'No UserParticular records found. Please create one before proceeding.'
else
  users_history.each do |history_data|
    UserHistory.create!(history_data)
  end
end
