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

# Seed NgoUser data
ngo_users_data = [
  { name: 'CARE International', image_url: 'care.png', created_at: DateTime.now, updated_at: DateTime.now,
    email: 'cisecretariat@careinternational.org', contact_number: '1-800-422-7385', website: 'https://www.care-international.org/' },
  { name: 'Amnesty International', image_url: 'AmnestyInternational.png', created_at: DateTime.now,
    updated_at: DateTime.now, email: 'contactus@amnesty.org', contact_number: '+44 20 74135500', website: 'https://www.amnesty.org/' },
  { name: 'Oxfam', image_url: 'oxfam.png', created_at: DateTime.now, updated_at: DateTime.now,
    email: 'oxfamsol@oxfamsol.be', contact_number: '+254 722 200417', website: 'https://www.oxfam.org/' },
  { name: 'World Vision', image_url: 'worldvision.png', created_at: DateTime.now, updated_at: DateTime.now,
    email: 'enquiries@worldvision.org.sg', contact_number: '+65 6922 0147', website: 'https://www.worldvision.org.sg/' },
  { name: 'Human Rights Watch', image_url: 'humanrightswatch.png', created_at: DateTime.now, updated_at: DateTime.now,
    email: '', contact_number: '+1-212-290-4700', website: 'https://www.hrw.org/' },
  { name: 'Gebirah', image_url: 'Gebirah.png', created_at: DateTime.now, updated_at: DateTime.now,
    email: 'gebirahad@gmail.com', contact_number: '', website: 'https://www.gebirah.org/' },
  { name: 'International Rescue Committee (IRC)', image_url: 'IRC.png', created_at: DateTime.now,
    updated_at: DateTime.now, email: 'DonorServices@Rescue.org', contact_number: '+ 1 212 551 3000', website: 'https://www.rescue.org/' },
  { name: 'Doctors Without Borders/Médecins Sans Frontières', image_url: 'MSF.png', created_at: DateTime.now,
    updated_at: DateTime.now, email: 'media@seeap.msf.org', contact_number: ' (852) 2959 4255 ', website: 'https://doctorswithoutborders-apac.org/' },
  { name: 'Norwegian Refugee Council (NRC)', image_url: 'NRC.png', created_at: DateTime.now, updated_at: DateTime.now,
    email: 'fundraising@nrc.no', contact_number: '+47 800 33 503', website: 'https://www.nrc.no/' },
  { name: 'Save the Children', image_url: 'Savethechildren.png', created_at: DateTime.now, updated_at: DateTime.now,
    email: 'info@savethechildren.org', contact_number: '+65 6511 3160', website: 'https://www.savethechildren.net/' },
  { name: 'UNHCR', image_url: 'unhcr.png', created_at: DateTime.now, updated_at: DateTime.now,
    email: 'mlslu@unhcr.org', contact_number: '+60 3 2118 4800', website: 'https://www.unhcr.org/' },
  { name: 'World Relief', image_url: 'world relief.png', created_at: DateTime.now, updated_at: DateTime.now,
    email: '', contact_number: '443-451-1900', website: 'https://worldrelief.org/' }
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
    # puts 'nil'
  else
    # Create/modify user data
    user_particular = user.user_particular || user.build_user_particular
    user_particular.assign_attributes(particulars_data)
    user_particular.save!
  end
end

UserParticular.first.update(unique_id: '1055290', two_fa_passcode: '606833')

# Create or update NgoUsers
ngo_users_data.each do |ngo_data|
  ngo_user = NgoUser.find_or_initialize_by(name: ngo_data[:name])
  ngo_user.update!(image_url: ngo_data[:image_url])
  ngo_user.update!(email: ngo_data[:email])
  ngo_user.update!(contact_number: ngo_data[:contact_number])
  ngo_user.update!(website: ngo_data[:website])
end

# Seed user history data for user_id 1
(1..15).each do |i|
  history_data = {
    activity_type: 'Event',
    activity_title: Faker::Lorem.words(number: rand(1..5)).join(' '),
    description: Faker::Lorem.words(number: rand(1..20)).join(' '),
    date: DateTime.now - rand(1..30),
    user_id: 1
  }

  user_history = UserHistory.find_or_initialize_by(id: i)
  user_history.update!(history_data)
end

# Seed bulletin data
bulletin_data = [
  {
    title: 'Gebirah Aid Giveaway',
    date: DateTime.new(2024, 7, 1),
    location: 'Singapore',
    description: 'Welfare giveaway event!',
    ngo_name: 'Gebirah',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'CARE Medical Camp',
    date: DateTime.new(2024, 8, 12),
    location: 'Kuala Lumpur',
    description: 'Free medical check-up and healthcare advice.',
    ngo_name: 'CARE International',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Amnesty Legal Aid',
    date: DateTime.new(2024, 8, 20),
    location: 'Penang',
    description: 'Legal assistance for underprivileged communities.',
    ngo_name: 'Amnesty International',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Oxfam Food Distribution',
    date: DateTime.new(2024, 9, 5),
    location: 'Ipoh',
    description: 'Providing food supplies to low-income families.',
    ngo_name: 'Oxfam',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'World Vision Education Fair',
    date: DateTime.new(2024, 10, 3),
    location: 'Kota Bharu',
    description: 'Promoting education for children in rural areas.',
    ngo_name: 'World Vision',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Human Rights Awareness Campaign',
    date: DateTime.new(2024, 11, 7),
    location: 'Johor Bahru',
    description: 'Raising awareness about human rights issues.',
    ngo_name: 'Human Rights Watch',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Gebirah Community Clean-up',
    date: DateTime.new(2024, 8, 30),
    location: 'Shah Alam',
    description: 'Community clean-up and recycling drive.',
    ngo_name: 'Gebirah',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'IRC Refugee Support',
    date: DateTime.new(2024, 9, 15),
    location: 'Seremban',
    description: 'Support services for refugees and asylum seekers.',
    ngo_name: 'International Rescue Committee (IRC)',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Doctors Without Borders Health Camp',
    date: DateTime.new(2024, 10, 21),
    location: 'Kuching',
    description: 'Medical assistance for underserved communities.',
    ngo_name: 'Doctors Without Borders/Médecins Sans Frontières',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'NRC Shelter Building',
    date: DateTime.new(2024, 11, 14),
    location: 'Alor Setar',
    description: 'Building shelters for homeless families.',
    ngo_name: 'Norwegian Refugee Council (NRC)',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Save the Children School Supplies Drive',
    date: DateTime.new(2024, 8, 28),
    location: 'Melaka',
    description: 'Collecting school supplies for children in need.',
    ngo_name: 'Save the Children',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'UNHCR Asylum Support',
    date: DateTime.new(2024, 9, 12),
    location: 'Miri',
    description: 'Providing support for asylum seekers.',
    ngo_name: 'UNHCR',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'World Relief Disaster Preparedness',
    date: DateTime.new(2024, 10, 6),
    location: 'Sandakan',
    description: 'Training for disaster preparedness and response.',
    ngo_name: 'World Relief',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Gebirah Youth Empowerment',
    date: DateTime.new(2024, 11, 23),
    location: 'Putrajaya',
    description: 'Workshops and training for youth empowerment.',
    ngo_name: 'Gebirah',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'CARE Water Sanitation Project',
    date: DateTime.new(2024, 12, 2),
    location: 'Petaling Jaya',
    description: 'Improving water sanitation in rural areas.',
    ngo_name: 'CARE International',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Amnesty Rights Workshop',
    date: DateTime.new(2024, 8, 25),
    location: 'Klang',
    description: 'Workshops on human rights and legal issues.',
    ngo_name: 'Amnesty International',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Oxfam Fundraiser',
    date: DateTime.new(2024, 9, 9),
    location: 'George Town',
    description: 'Fundraising event for poverty alleviation.',
    ngo_name: 'Oxfam',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'World Vision Child Sponsorship',
    date: DateTime.new(2024, 11, 30),
    location: 'Kuantan',
    description: 'Promoting child sponsorship programs.',
    ngo_name: 'World Vision',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Human Rights Watch Film Screening',
    date: DateTime.new(2024, 9, 19),
    location: 'Bintulu',
    description: 'Screening of films on human rights issues.',
    ngo_name: 'Human Rights Watch',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'IRC Job Fair',
    date: DateTime.new(2024, 10, 17),
    location: 'Labuan',
    description: 'Job fair for refugees and asylum seekers.',
    ngo_name: 'International Rescue Committee (IRC)',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  },
  {
    title: 'Doctors Without Borders Vaccination Drive',
    date: DateTime.new(2024, 12, 5),
    location: 'Sibu',
    description: 'Vaccination drive for children and adults.',
    ngo_name: 'Doctors Without Borders/Médecins Sans Frontières',
    saved: false,
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
]

# Create or update Bulletins
bulletin_data.each do |each_bulletin_data|
  bulletin = Bulletin.find_or_initialize_by(title: each_bulletin_data[:title])
  bulletin.update!(each_bulletin_data)
end
