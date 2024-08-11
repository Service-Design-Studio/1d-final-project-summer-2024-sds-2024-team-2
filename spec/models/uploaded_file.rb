require 'rails_helper'

RSpec.describe UploadedFile, type: :model do
  let(:user) { create(:user) }
  let(:user_particular) { create(:user_particular, user: user) }
  let(:uploaded_file) { create(:uploaded_file, user: user, user_particular: user_particular) }

  describe 'Associations' do
    it { should belong_to(:user_particular) }
    it { should belong_to(:user) }
    it { should have_one_attached(:file_path) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:file_type) }
    it { should validate_presence_of(:file_size) }
    it { should validate_presence_of(:file_path) }

    context 'when a file is attached' do
      it 'is valid with valid attributes' do
        expect(uploaded_file).to be_valid
      end
    end

    context 'when a file is not attached' do
      it 'is not valid without a file_path' do
        uploaded_file.file_path = nil
        expect(uploaded_file).not_to be_valid
        expect(uploaded_file.errors[:file_path]).to include("can't be blank")
      end
    end
  end

  describe '#file_url' do
    context 'when a file is attached' do
      it 'returns the file URL' do
        expect(uploaded_file.file_url).to eq(Rails.application.routes.url_helpers.rails_blob_path(uploaded_file.file_path, only_path: true))
      end
    end

    context 'when a file is not attached' do
      it 'returns nil' do
        uploaded_file.file_path.detach
        expect(uploaded_file.file_url).to be_nil
      end
    end
  end

  describe 'Scopes' do
    let!(:verified_file) { create(:uploaded_file, user: user, user_particular: user_particular, status: 'Verified') }
    let!(:unverified_file) { create(:uploaded_file, user: user, user_particular: user_particular, status: 'Unverified') }

    describe '.verified' do
      it 'includes only files with a status of Verified' do
        expect(UploadedFile.verified).to include(verified_file)
        expect(UploadedFile.verified).not_to include(unverified_file)
      end
    end
  end
end
