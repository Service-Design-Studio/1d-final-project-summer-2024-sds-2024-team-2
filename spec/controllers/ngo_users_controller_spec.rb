require 'rails_helper'

RSpec.describe NgoUsersController, type: :controller do
    include Devise::Test::ControllerHelpers

    # Create new user particular for testing
    before(:all) do
        @user = User.find_or_create_by!(username: 'newuser') do |user|
        user.email = 'newuser@mail.com'
        user.password = 'password'
        user.phone_number = '91234567'
        end
        
        @valid_attributes = {
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

        @user_particular = UserParticular.create_user_particular(@valid_attributes)

        ngo_users_data = [
          { name: 'Test NGO 1', image_url: 'test_ngo_1.png' },
          { name: 'Test NGO 2', image_url: 'test_ngo_2.png' },
          { name: 'Oxfam', image_url: 'oxfam.png' },
          { name: 'World Vision', image_url: 'worldvision.png' },
          { name: 'Human Rights Watch', image_url: 'humanrightswatch.png' }
        ]

        @ngo_users = ngo_users_data.map do |ngo_data|
          NgoUser.find_or_create_by(name: ngo_data[:name]) do |ngo_user|
            ngo_user.image_url = ngo_data[:image_url]
          end
        end

        @ngo_user = @ngo_users[0]
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
        ActiveRecord::Base.connection.execute('DELETE FROM user_particulars')
        ActiveRecord::Base.connection.execute('DELETE FROM users')
        ActiveRecord::Base.connection.execute('DELETE FROM ngo_users')
    end

    describe 'GET #new' do
        it 'renders new template' do
            get :new, params: { id: @ngo_user.id}
            expect(response).to render_template(:new)
        end
    end
    
    describe 'GET #show' do
        it 'renders show template' do
            get :show, params: { id: @ngo_user.id}
            expect(response).to render_template(:show)
        end
    end

    describe 'GET #index' do
      context 'without search parameter' do
        it 'renders the index template and gets all ngo_users' do
          # Assuming you have some ngo_users in your test database or you can create them using FactoryBot
          get :index
          expect(response).to render_template(:index)
          expect(assigns(:ngo_users)).to match_array(@ngo_users)
        end
      end
  
      context 'with search parameter' do
        it 'renders the index template and gets filtered ngo_users' do
          get :index, params: { search: 'Test' }

          filtered_ngos = NgoUser.where('name LIKE ?', '%Test%')
          expect(assigns(:ngo_users)).to match_array(filtered_ngos)
          expect(response).to render_template(:index)
        end
      end
    end
end