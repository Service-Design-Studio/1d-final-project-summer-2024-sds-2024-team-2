require 'rails_helper'

RSpec.describe UploadedFilesController, type: :controller do
  let(:user) { create(:user) }
  let(:user_particular) { create(:user_particular, user: user) }
  let(:uploaded_file) { create(:uploaded_file, user_particular: user_particular) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a list of uploaded files' do
      uploaded_file
      get :index, params: { user_particular_id: user_particular.id }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response).to be_an(Array)
      expect(json_response.first).to have_key('file_url')
    end

    it 'returns an error if user_particular is not found' do
      get :index, params: { user_particular_id: -1 }
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to include('UserParticular not found')
    end
  end

  describe 'POST #create' do
    let(:file) { fixture_file_upload(Rails.root.join('spec/fixtures/sample_document.pdf'), 'application/pdf') }

    context 'with valid parameters' do
      it 'creates a new uploaded file' do
        post :create, params: {
          user_particular_id: user_particular.id,
          uploaded_file: {
            file_path: file,
            name: 'Sample Document',
            file_type: 'application/pdf',
            file_size: file.size,
            description: 'Test Description',
            document_type: 'Education'
          }
        }
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be true
        expect(json_response['file']['name']).to eq('Sample Document')
      end
    end

    context 'with missing file_path' do
      it 'returns an error' do
        post :create, params: {
          user_particular_id: user_particular.id,
          uploaded_file: {
            name: 'Sample Document',
            file_type: 'application/pdf',
            file_size: 1234,
            description: 'Test Description',
            document_type: 'Education'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include('File path is missing')
      end
    end

    context 'when an exception occurs' do
      it 'returns an internal server error' do
        allow_any_instance_of(UploadedFile).to receive(:save).and_raise(StandardError, 'Unexpected error')
        post :create, params: {
          user_particular_id: user_particular.id,
          uploaded_file: {
            file_path: file,
            name: 'Sample Document',
            file_type: 'application/pdf',
            file_size: file.size,
            description: 'Test Description',
            document_type: 'Education'
          }
        }
        expect(response).to have_http_status(:internal_server_error)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include('Failed to upload file')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the uploaded file' do
        patch :update, params: {
          user_particular_id: user_particular.id,
          id: uploaded_file.id,
          uploaded_file: { description: 'Updated Description' }
        }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be true
        expect(json_response['file']['description']).to eq('Updated Description')
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        patch :update, params: {
          user_particular_id: user_particular.id,
          id: uploaded_file.id,
          uploaded_file: { description: nil }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("Description can't be blank")
      end
    end

    context 'when an exception occurs' do
      it 'returns an internal server error' do
        allow_any_instance_of(UploadedFile).to receive(:update).and_raise(StandardError, 'Unexpected error')
        patch :update, params: {
          user_particular_id: user_particular.id,
          id: uploaded_file.id,
          uploaded_file: { description: 'Updated Description' }
        }
        expect(response).to have_http_status(:internal_server_error)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include('Failed to update file')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the file is successfully deleted' do
      it 'deletes the uploaded file' do
        uploaded_file
        expect {
          delete :destroy, params: { user_particular_id: user_particular.id, id: uploaded_file.id }
        }.to change(UploadedFile, :count).by(-1)
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be true
      end
    end

    context 'when the file does not exist' do
      it 'returns an error' do
        delete :destroy, params: { user_particular_id: user_particular.id, id: -1 }
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include('UploadedFile not found')
      end
    end

    context 'when an exception occurs' do
      it 'returns an internal server error' do
        allow_any_instance_of(UploadedFile).to receive(:destroy).and_raise(StandardError, 'Unexpected error')
        delete :destroy, params: { user_particular_id: user_particular.id, id: uploaded_file.id }
        expect(response).to have_http_status(:internal_server_error)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include('Failed to delete file')
      end
    end
  end
end
