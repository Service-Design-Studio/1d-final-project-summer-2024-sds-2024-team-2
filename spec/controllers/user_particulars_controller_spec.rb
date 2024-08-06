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
      full_name: "Invalid@ name",
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

    ngo_users_data = [
      { 
        name: 'Test NGO 1', 
        image_url: 'test_ngo_1.png', 
        created_at: DateTime.now, 
        updated_at: DateTime.now,
        email: 'contact@testngo1.org', 
        contact_number: '+123 456 7890', 
        website: 'https://www.testngo1.org/',
        services: ['Education'] 
      },
      { 
        name: 'Test NGO 2', 
        image_url: 'test_ngo_2.png', 
        created_at: DateTime.now, 
        updated_at: DateTime.now,
        email: 'contact@testngo2.org', 
        contact_number: '+123 456 7891', 
        website: 'https://www.testngo2.org/',
        services: ['Education'] 
      },
      { 
        name: 'Test NGO 3', 
        image_url: 'test_ngo_3.png', 
        created_at: DateTime.now, 
        updated_at: DateTime.now,
        email: 'contact@testngo3.org', 
        contact_number: '+123 456 7891', 
        website: 'https://www.testngo3.org/',
        services: ['Healthcare'] 
      }
    ]

    @ngo_users = ngo_users_data.map do |ngo_data|
      ngo_user = NgoUser.find_or_create_by(name: ngo_data[:name]) do |ngo_user|
        ngo_user.image_url = ngo_data[:image_url]
        ngo_user.email = ngo_data[:email]
        ngo_user.contact_number = ngo_data[:contact_number]
        ngo_user.website = ngo_data[:website]
        ngo_user.created_at = ngo_data[:created_at]
        ngo_user.updated_at = ngo_data[:updated_at]
      end
    end

    @ngo_services = @ngo_users.each_with_index do |ngo_user, index|
      ngo_users_data[index][:services].each do |service_name|
        service = ngo_user.ngo_services.find_or_initialize_by(services: service_name)
        service.save!
      end
    end

  end

  before do
    # Sign in the user before each test
    sign_in @user
  end

  # Rollback transaction after each test suite
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
  end  

  describe 'GET #show' do
    it 'renders show template' do
      @user_particular = UserParticular.create(@valid_attributes)
      @user_particular = UserParticular.create(@valid_attributes)
      get :show, params: { id: @user_particular.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #document' do
    it 'renders document template' do
      @user_particular = UserParticular.create(@valid_attributes)
      @user_particular = UserParticular.create(@valid_attributes)
      get :document, params: { id: @user_particular.id }
      expect(response).to render_template(:document)
    end
  end

  describe 'GET #new' do
    context 'when session has user_particular_params' do
      it 'fills up the form with previously filled data' do
        session[:user_particular_params] = @valid_attributes.except(:user_id)
        get :new

        expect(assigns(:user_particular)).to have_attributes(@valid_attributes.except(:user_id))
        expect(response).to render_template(:new)
      end
    end

    context 'when session does not have user_particular_params' do
      it 'creates a new empty UserParticular object' do
        session[:user_particular_params] = nil
        get :new

        expect(assigns(:user_particular)).to be_a_new(UserParticular)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    context 'after user edits particulars with failed parameters' do
      it 'renders edit template with data from parameters' do
        @user_particular_db = UserParticular.create(@valid_attributes) #create to provide the id for edit action
        @user_particular_db = UserParticular.create(@valid_attributes) #create to provide the id for edit action
        @param_attributes = @valid_attributes.merge(full_name: 'Not John', id: @user_particular_db.id)
        @user_particular = UserParticular.new(@param_attributes)
        get :edit, params: { id: @user_particular_db.id, user_particular: @param_attributes }
        
        # Check that :user_particular is correctly assigned to database record
        expect(assigns(:user_particular)).to eq(@user_particular)
        expect(response).to render_template(:edit)
      end
    end

    context 'user opens edit particulars page initially' do
      it 'renders edit template with data from database' do
        @user_particular = UserParticular.create(@valid_attributes)
        @user_particular = UserParticular.create(@valid_attributes)
        get :edit, params: { id: @user_particular.id }
        
        # Check that :user_particular is correctly assigned to database record
        expect(assigns(:user_particular)).to eq(@user_particular)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new UserParticular' do
        post :create, params: { user_particular: @valid_attributes }
        expect(response).to redirect_to(user_particular_path(UserParticular.last))
        expect(flash[:success]). to eq 'Digital ID was successfully created!'
      end
    end

    context 'with invalid params' do
      it 'missing username, so does not create a new UserParticular' do
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

  describe 'GET #confirm' do
    context 'with valid params' do
      it 'renders the confirm template' do
        # Set the session directly
        get :confirm, params: { user_particular: @valid_attributes}
        expect(response).to render_template(:confirm)
      end
    end

    context 'with invalid params' do
      it 'redirects to the new template with error messages if validation fails' do
        # Set the session directly
        get :confirm, params: { user_particular: @invalid_attributes}
        expect(response).to redirect_to(new_user_particular_path)
        expect(flash[:error_message]).to eq('Please fix the error(s) below:')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the UserParticular' do
        user_particular = UserParticular.create!(@valid_attributes)
        patch :update, params: { id: user_particular.id, user_particular: @valid_attributes.merge(full_name: 'new name') }

        user_particular.reload # Reload to get updated attributes
        expect(response).to redirect_to(user_particular_path(user_particular))
        expect(flash[:success]).to eq 'Digital ID was successfully edited!'
      end
    end

    context 'with invalid params' do
      it 'does not pass controller validation and update the UserParticular' do
        user_particular = UserParticular.create!(@valid_attributes) # Create an initial record
        patch :update, params: { id: user_particular.id, user_particular: @invalid_attributes }
    
        expect(response).to redirect_to(edit_user_particular_path(user_particular.id, user_particular: @invalid_attributes))
        expect(flash[:error_message]).to eq 'Edit failed. Please fix the error(s) below:'
      end
    end
    
    context 'with empty params' do
      it 'does not get pass model validation and update the UserParticular' do
        user_particular = UserParticular.create!(@valid_attributes) # Create an initial record
        patch :update, params: { id: user_particular.id, user_particular: @invalid_attributes.merge(religion: '') } #empty religion field will fail model check
    
        expect(response).to redirect_to(edit_user_particular_path(user_particular.id, user_particular: @invalid_attributes))
        expect(flash[:error_message]).to eq 'Edit failed'
      end
    end
  end

  describe 'POST #generate_2fa' do
    context 'when 2FA passcode generation is successful' do
      it 'generates and returns a 2FA passcode' do
        @user_particular = UserParticular.create(@valid_attributes)
        post :generate_2fa, params: { id: @user_particular.id }, format: :json

        @user_particular.reload
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['two_fa_passcode']).to eq(@user_particular.two_fa_passcode)
      end
    end

    context 'when 2FA passcode generation fails' do
      it 'returns an error message' do
        @user_particular = UserParticular.create(@valid_attributes)

        # Force the save method called in generate_2fa to return false
        allow_any_instance_of(UserParticular).to receive(:save).and_return(false)

        post :generate_2fa, params: { id: @user_particular.id }, format: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Failed to generate 2FA passcode')
      end
    end
  end

  describe 'PATCH #validate_user_particulars' do
    # Define a helper method for validation
    def validate_user_particulars(attributes)
      controller.send(:validate_user_particulars, attributes)
    end

    context 'with valid attributes' do
      it 'returns no error messages' do
        error_messages = validate_user_particulars(@valid_attributes)
        expect(error_messages).to be_empty
      end
    end

    context 'with invalid full name' do
      it 'adds an error message for invalid full name' do
        invalid_attributes = @valid_attributes.merge(full_name: 'John123!')
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Full name can only contain valid letters and symbols.')
      end
    end

    context 'with invalid phone numbers' do
      it 'adds an error message when phone number is invalid' do
        invalid_attributes = @valid_attributes.merge(phone_number: '123-ABCD')
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Phone number can only contain numbers and hyphens.')
      end

      it 'adds an error message when secondary phone number is invalid' do
        invalid_attributes = @valid_attributes.merge(secondary_phone_number: '123abc456')
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Secondary phone number can only contain numbers and hyphens.')
      end
    end

    context 'with missing secondary phone number details' do
      it 'adds an error message when secondary phone number exists without country code' do
        invalid_attributes = @valid_attributes.merge(secondary_phone_number: '1234567890', secondary_phone_number_country_code: '')
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Secondary country code must exist if secondary phone number exists.')
      end
    
      it 'adds an error message when secondary country code exists without phone number' do
        invalid_attributes = @valid_attributes.merge(secondary_phone_number: '', secondary_phone_number_country_code: '1')
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Secondary phone number must exist if secondary country code exists.')
      end
    end

    context 'with invalid dropdown options' do
      it 'adds error messages for invalid country of origin' do
        invalid_attributes = @valid_attributes.merge(country_of_origin: 'loremipsum')
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Select country of origin from the dropdown list.')
      end
      
      #TODO: replace and create new test cases using the new user validation method
      xit 'adds error messages for invalid ethnicity' do
        invalid_attributes = @valid_attributes.merge(ethnicity: 'loremipsum')
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Select ethnicity from the dropdown list.')
      end

      xit 'adds error messages for invalid religion' do
        invalid_attributes = @valid_attributes.merge(religion: 'loremipsum')
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Select religion from the dropdown list.')
      end
    end

    context 'with future date of birth' do
      it 'adds an error message for date of birth in the future' do
        invalid_attributes = @valid_attributes.merge(date_of_birth: (Date.today + 1).to_s)
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Date of birth cannot be in the future.')
      end
    end

    context 'with future date of arrival' do
      it 'adds an error message for date of arrival in the future' do
        invalid_attributes = @valid_attributes.merge(date_of_arrival: (Date.today + 1).to_s)
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Date of arrival cannot be in the future.')
      end
    end

    context 'with date of arrival earlier than date of birth' do
      it 'adds an error message for date of arrival earlier than date of birth' do
        invalid_attributes = @valid_attributes.merge(date_of_arrival: '2000-01-01')
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Date of arrival cannot be earlier than date of birth.')
      end
    end
  end

  describe 'GET #contact_ngo' do
    context 'no search param' do
      it 'renders contact ngo template with all ngo users' do
        user_particular = UserParticular.create(@valid_attributes)
        get :contact_ngo, params: { id: user_particular.id }

        expect(assigns(:ngo_users)).to eq(NgoUser.all)
        expect(response).to render_template(:contact_ngo)
      end
    end

    context 'with search param' do
      it 'renders contact ngo template with filtered ngo users' do
        user_particular = UserParticular.create(@valid_attributes)
        get :contact_ngo, params: { id: user_particular.id, search: 'Education' }
    
        filtered_ngo_users = [
          NgoUser.find_by(name: 'Test NGO 1'),
          NgoUser.find_by(name: 'Test NGO 2')
        ]
        expect(assigns(:ngo_users)).to match_array(filtered_ngo_users)
        expect(response).to render_template(:contact_ngo)
      end
    end    
  end
end