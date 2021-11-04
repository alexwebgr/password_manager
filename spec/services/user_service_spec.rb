require 'rails_helper'

RSpec.describe UserService, type: :service do
  describe 'when a file is provided with 3 valid users' do
    let(:file) { file_fixture('users.csv').read }

    it "creates 3 new users" do
      expect {
        described_class.create_users(file)
      }.to change(User, :count).by(3)
    end
  end

  describe 'when a file is provided with 3 valid users one user without email' do
    let(:file) { file_fixture('users_missing_name.csv').read }

    it "creates 3 new users" do
      expect {
        described_class.create_users(file)
      }.to change(User, :count).by(3)
    end
  end
end
