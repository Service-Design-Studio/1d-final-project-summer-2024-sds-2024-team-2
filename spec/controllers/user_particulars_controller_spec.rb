require 'rails_helper'

RSpec.describe UserParticularsController, type: :controller do
    include Devise::Test::ControllerHelpers

    # Create new user and attributes for testing
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

        @invalid_attributes = {
        user_id: @user.id,
        full_name: 'John Tan',
        phone_number_country_code: '+65',
        phone_number: '91234567',
        secondary_phone_number_country_code: '+60',
        secondary_phone_number: '900001314',
        full_phone_number: '6591234567',
        country_of_origin: 'Myanmar',
        ethnicity: '', # Missing ethnicity
        religion: 'Buddhism',
        gender: 'Male',
        date_of_birth: Date.new(2001, 11, 1),
        date_of_arrival: Date.new(2019, 10, 20),
        photo_url: 'https://example.com/john_tan_photo.jpg',
        birth_certificate_url: 'https://example.com/john_tan_birth_certificate.jpg',
        passport_url: 'https://example.com/john_tan_passport.jpg'
        }
    end

    before do
        # Sign in the user before each test
        sign_in @user
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

    describe 'GET #show' do
        it 'renders show template' do
            @user_particular = UserParticular.create_user_particular(@valid_attributes)
            get :show, params: { id: @user_particular.id }
            expect(response).to render_template(:show)
        end
    end

    # Need to change name accordingly when controller action changes
    describe 'GET #page2' do
        it 'renders page2 template' do
            @user_particular = UserParticular.create_user_particular(@valid_attributes)
            get :page2, params: { id: @user_particular.id }
            expect(response).to render_template(:page2)
        end
    end

    describe 'GET #new' do
        it 'renders new template' do
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe 'GET #edit' do
        it 'renders edit template' do
            @user_particular = UserParticular.create_user_particular(@valid_attributes)
            get :edit, params: { id: @user_particular.id }
            expect(response).to render_template(:edit)
        end
    end

    #TODO: Incomplete test
    describe 'POST #create' do
        context 'with valid params' do
            it 'creates a new UserParticular' do
                post :create, params: { user_particular: @valid_attributes }
                expect(response).to redirect_to(user_particular_path(UserParticular.last))
                expect(flash[:success]). to eq 'Digital ID was successfully created!'
            end
        end

        context 'with invalid params' do
            it 'empty ethnicity, so does not create a new UserParticular' do
                post :create, params: { user_particular: @invalid_attributes }
                expect(response).to redirect_to(user_particulars_confirm_path(user_particular: @invalid_attributes))
                expect(flash[:error_message]). to eq 'Digital ID creation failed. Please try again.'
            end
            it 'user id dont exist, so does not create a new UserParticular' do
                post :create, params: { user_particular: @valid_attributes.merge(user_id: 999999) }
                expect(response).to redirect_to(user_particulars_confirm_path(user_particular: @valid_attributes.merge(user_id: 999999)))
                expect(flash[:error_message]). to eq 'Digital ID creation failed. Please try again.'
            end
        end
    end

    # #TODO: Incomplete test
    # describe 'POST #confirm' do
    #     xit 'renders new with an error if full name contains numbers' do
    #         post :confirm, params: { full_name: 'John123', phone_number: '1234567890' }
    #         expect(flash[:error]).to include('Full name can only contain valid letters and symbols.')
    #         expect(response).to render_template(:new)
    #     end

    #     xit 'renders new with an error if phone number contains letters' do
    #         post :confirm, params: { full_name: 'John', phone_number: '123abc7890' }
    #         expect(flash[:error]).to include('Phone number can only contain numbers and hyphens.')
    #         expect(response).to render_template(:new)
    #     end

    #     xit 'renders new with an error if secondary phone number contains letters' do
    #         post :confirm, params: { full_name: 'John', phone_number: '1234567890', secondary_phone_number: '123abc7890' }
    #         expect(flash[:error]).to include('Secondary phone number can only contain numbers and hyphens.')
    #         expect(response).to render_template(:new)
    #     end

    #     xit 'renders new with an error if country of origin contains non-letters' do
    #         post :confirm, params: { full_name: 'John', phone_number: '1234567890', country_of_origin: 'USA123' }
    #         expect(flash[:error]).to include('Country of origin should only contain letters.')
    #         expect(response).to render_template(:new)
    #     end
      
    #     xit 'renders new with an error if date of birth is in the future' do
    #         post :confirm, params: { date_of_birth: (Date.today + 1).to_s }
    #         expect(flash[:error]).to include('Date of birth cannot be in the future.')
    #         expect(response).to render_template(:new)
    #     end

    #     xit 'renders new with an error if date of arrival is in the future' do
    #         post :confirm, params: { date_of_arrival: (Date.today + 1).to_s }
    #         expect(flash[:error]).to include('Date of arrival cannot be in the future.')
    #         expect(response).to render_template(:new)
    #     end

    #     xit 'renders new with an error if date of arrival is earlier than date of birth' do
    #         post :confirm, params: { date_of_birth: '2020-01-01', date_of_arrival: '2000-01-01' }
    #         expect(flash[:error]).to include('Date of arrival cannot be earlier than date of birth.')
    #         expect(response).to render_template(:new)
    #     end

    #     xit 'renders confirm if no validation errors' do
    #         post :confirm, params: { full_name: 'John Doe', phone_number: '1234567890', secondary_phone_number: '0987654321', country_of_origin: 'USA' }
    #         expect(response).to render_template(:confirm)
    #     end
    # end

    #TODO: Incomplete test
    describe 'POST #update' do
        xit 'renders edit template' do
            get :edit
            expect(response).to render_template(:edit)
        end
    end
end