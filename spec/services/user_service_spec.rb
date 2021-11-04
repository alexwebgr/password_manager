require 'rails_helper'

RSpec.describe UserService, type: :service do
  describe '#create_users' do
    describe 'when a file is provided with 3 valid users' do
      let(:file) { file_fixture('3_valid_users.csv').read }

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

  describe '#determine_chars' do
    describe 'when a password is missing a uppercase character, a digit and has 3 s' do
      let(:password) { 'passswordi' }
      let(:user) { User.new(name: 'alex', password: password) }

      it "returns the value" do
        user.save
        expect(described_class.new.determine_chars(user.errors.full_messages, password)).to eq 3
      end
    end

    describe 'when a password has 3 s' do
      let(:password) { 'Passsword1p' }
      let(:user) { User.new(name: 'alex', password: password) }

      it "returns the value" do
        user.save
        expect(described_class.new.determine_chars(user.errors.full_messages, password)).to eq 1
      end
    end

    describe 'when a password missing a lowercase' do
      let(:password) { 'PASSWORD22' }
      let(:user) { User.new(name: 'alex', password: password) }

      it "returns the value" do
        user.save
        expect(described_class.new.determine_chars(user.errors.full_messages, password)).to eq 1
      end
    end

    describe 'when a password missing a uppercase' do
      let(:password) { 'password1p' }
      let(:user) { User.new(name: 'alex', password: password) }

      it "returns the value" do
        user.save
        expect(described_class.new.determine_chars(user.errors.full_messages, password)).to eq 1
      end
    end

    describe 'when a password missing a digit' do
      let(:password) { 'Passwordpp' }
      let(:user) { User.new(name: 'alex', password: password) }

      it "returns the value" do
        user.save
        expect(described_class.new.determine_chars(user.errors.full_messages, password)).to eq 1
      end
    end

    describe 'when a password is too short' do
      let(:password) { 'pass' }
      let(:user) { User.new(name: 'alex', password: password) }

      it "returns the value" do
        user.save
        expect(described_class.new.determine_chars(user.errors.full_messages, password)).to eq 8
      end
    end

    describe 'when a password is too long' do
      let(:password) { 'StrongPass2StrongPass2' }
      let(:user) { User.new(name: 'alex', password: password) }

      it "returns the value" do
        user.save
        expect(described_class.new.determine_chars(user.errors.full_messages, password)).to eq 6
      end
    end
  end
end
