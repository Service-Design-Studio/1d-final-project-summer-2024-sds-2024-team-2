require 'rails_helper'

RSpec.describe UserParticularsController, type: :controller do
    describe 'POST #confirm' do
        it 'renders new with an error if full name contains numbers' do
            post :confirm, params: { full_name: 'John123', phone_number: '1234567890' }
            expect(flash[:error]).to include('Full name cannot contain numbers.')
            expect(response).to render_template(:new)
        end

        it 'renders new with an error if phone number contains letters' do
            post :confirm, params: { full_name: 'John', phone_number: '123abc7890' }
            expect(flash[:error]).to include('Phone number cannot contain letters.')
            expect(response).to render_template(:new)
        end

        it 'renders new with an error if secondary phone number contains letters' do
            post :confirm, params: { full_name: 'John', phone_number: '1234567890', secondary_phone_number: '123abc7890' }
            expect(flash[:error]).to include('Secondary phone number cannot contain letters.')
            expect(response).to render_template(:new)
        end

        it 'renders new with an error if country of origin contains non-letters' do
            post :confirm, params: { full_name: 'John', phone_number: '1234567890', country_of_origin: 'USA123' }
            expect(flash[:error]).to include('Country of origin should only contain letters.')
            expect(response).to render_template(:new)
        end

        it 'renders confirm if no validation errors' do
            post :confirm, params: { full_name: 'John Doe', phone_number: '1234567890', secondary_phone_number: '0987654321', country_of_origin: 'USA' }
            expect(response).to render_template(:confirm)
        end
    end
end