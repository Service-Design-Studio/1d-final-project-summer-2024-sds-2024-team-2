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

    describe 'GET #confirm' do
        context 'with valid params' do
            it 'renders the confirm template' do
                # Set the session directly
                session[:user_particular_params] = @valid_attributes
                get :confirm
                expect(response).to render_template(:confirm)
            end
        end

        context 'with invalid params' do
            it 'redirects to the new template with error messages if validation fails' do
                # Set the session directly
                session[:user_particular_params] = @invalid_attributes
                get :confirm
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
            expect(user_particular.full_name).to eq 'new name'
            end
        end

        context 'with invalid params' do
            it 'does not update the UserParticular if params are invalid' do
              user_particular = UserParticular.create!(@valid_attributes) # Create an initial record
              patch :update, params: { id: user_particular.id, user_particular: @invalid_attributes }
          
              # Ensure the response redirects to the confirm page with the invalid parameters
              expect(response).to redirect_to(user_particulars_confirm_path(user_particular: @invalid_attributes))
              expect(flash[:error_message]).to eq 'Edit failed. Please try again.'
          
              # Reload the user_particular to ensure no changes were made
              user_particular.reload
              expect(user_particular.full_name).to eq @valid_attributes[:full_name] # Ensure no update occurred
            end
          end        

        context 'with non-existent UserParticular' do
            it 'handles the case when the UserParticular does not exist' do
                # Attempt to update a UserParticular with an ID that doesn't exist
                patch :update, params: { id: 99999, user_particular: @valid_attributes.merge(full_name: 'new name') }
            
                # Ensure the response redirects to the confirm page with the provided parameters
                expect(response).to redirect_to(user_particulars_confirm_path(user_particular: @valid_attributes.merge(full_name: 'new name')))
                expect(flash[:error_message]).to eq 'Edit failed. Please try again.'
            end
        end
    end

    describe 'POST #generate_2fa' do
        context 'when 2FA passcode generation is successful' do
            it 'generates and returns a 2FA passcode' do
            @user_particular = UserParticular.create_user_particular(@valid_attributes)
            post :generate_2fa, params: { id: @user_particular.id }, format: :json

            @user_particular.reload
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body)['two_fa_passcode']).to eq(@user_particular.two_fa_passcode)
            end
        end

        context 'when 2FA passcode generation fails' do
            it 'returns an error message' do
            @user_particular = UserParticular.create_user_particular(@valid_attributes)

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
      it 'adds error messages for invalid phone numbers' do
        invalid_attributes = @valid_attributes.merge(phone_number: '123-ABCD', secondary_phone_number: '123abc456')
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Phone number can only contain numbers and hyphens.')
        expect(error_messages).to include('Secondary phone number can only contain numbers and hyphens.')
      end
    end

    context 'with invalid dropdown options' do
      it 'adds error messages for invalid dropdown options' do
        invalid_attributes = @valid_attributes.merge(country_of_origin: 'NotInDropdown', ethnicity: '', religion: '')
        error_messages = validate_user_particulars(invalid_attributes)
        expect(error_messages).to include('Select country of origin from the dropdown list.')
        expect(error_messages).to include('Select ethnicity from the dropdown list.')
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

  describe '#validate_user_particulars' do
    it 'returns an error if full_name contains numbers' do
      user_particular = @valid_attributes.merge(full_name: 'John123')
      errors = @controller.validate_user_particulars(user_particular)
      expect(errors).to include('Full name can only contain valid letters and symbols.')
    end

    it 'returns an error if phone_number contains letters' do
      user_particular = @valid_attributes.merge(phone_number: '123abc456')
      errors = @controller.validate_user_particulars(user_particular)
      expect(errors).to include('Phone number can only contain numbers and hyphens.')
    end

    it 'returns an error if secondary_phone_number contains letters' do
      user_particular = @valid_attributes.merge(secondary_phone_number: '123abc456')
      errors = @controller.validate_user_particulars(user_particular)
      expect(errors).to include('Secondary phone number can only contain numbers and hyphens.')
    end

    it 'returns an error if country_of_origin is invalid' do
      user_particular = @valid_attributes.merge(country_of_origin: 'InvalidCountry')
      errors = @controller.validate_user_particulars(user_particular)
      expect(errors).to include('Select country of origin from the dropdown list.')
    end

    it 'returns an error if ethnicity is missing' do
      user_particular = @valid_attributes.merge(ethnicity: '')
      errors = @controller.validate_user_particulars(user_particular)
      expect(errors).to include('Select ethnicity from the dropdown list.')
    end

    it 'returns an error if religion is invalid' do
      user_particular = @valid_attributes.merge(religion: 'InvalidReligion')
      errors = @controller.validate_user_particulars(user_particular)
      expect(errors).to include('Select religion from the dropdown list.')
    end

    it 'returns an error if date_of_birth is in the future' do
      user_particular = @valid_attributes.merge(date_of_birth: (Date.today + 1).to_s)
      errors = @controller.validate_user_particulars(user_particular)
      expect(errors).to include('Date of birth cannot be in the future.')
    end

    it 'returns an error if date_of_arrival is in the future' do
      user_particular = @valid_attributes.merge(date_of_arrival: (Date.today + 1).to_s)
      errors = @controller.validate_user_particulars(user_particular)
      expect(errors).to include('Date of arrival cannot be in the future.')
    end

    it 'returns an error if date_of_arrival is earlier than date_of_birth' do
      user_particular = @valid_attributes.merge(date_of_birth: '2020-01-01', date_of_arrival: '2000-01-01')
      errors = @controller.validate_user_particulars(user_particular)
      expect(errors).to include('Date of arrival cannot be earlier than date of birth.')
    end

    it 'returns no errors if all attributes are valid' do
      user_particular = @valid_attributes
      errors = @controller.validate_user_particulars(user_particular)
      expect(errors).to be_empty
    end
  end
end