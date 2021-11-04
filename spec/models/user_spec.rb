require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(10) }
    it { should validate_length_of(:password).is_at_most(16) }

    describe 'when a password is missing a uppercase character' do
      let(:password) { 'password22' }
      let(:user) { User.new(name: 'alex', password: password) }

      it "does not create a user" do
        user.save
        expect(user.errors.full_messages).to eq ["Password needs to contain a uppercase character"]
      end
    end

    describe 'when a password is missing a lowercase character' do
      let(:password) { 'PASSWORD22' }
      let(:user) { User.new(name: 'alex', password: password) }

      it "does not create a user" do
        user.save
        expect(user.errors.full_messages).to eq ["Password needs to contain a lowercase character"]
      end
    end

    describe 'when a password is missing a digit' do
      let(:password) { 'Passwordmy' }
      let(:user) { User.new(name: 'alex', password: password) }

      it "does not create a user" do
        user.save
        expect(user.errors.full_messages).to eq ["Password needs to contain a digit"]
      end
    end

    describe 'when a password has repeating but non-consecutive characters' do
      let(:password) { 'Password22fuss' }
      let(:user) { User.new(name: 'alex', password: password) }

      it "creates a user" do
        user.save
        expect(user.name).to eq 'alex'
      end
    end

    describe 'when a password has 3 consecutive characters' do
      let(:password) { 'Passsword22' }
      let(:user) { User.new(name: 'alex', password: password) }

      it "does not create a user" do
        user.save
        expect(user.errors.full_messages).to eq ["Password cannot contain three repeating characters in a row"]
      end
    end
  end
end
