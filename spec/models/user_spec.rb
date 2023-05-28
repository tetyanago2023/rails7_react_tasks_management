# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_uniqueness_of(:email) }

    it { should have_secure_password }

    context 'email format validation' do
      let(:user) { FactoryBot.build(:user, email:) }

      context 'when format is valid' do
        let(:email) { 'valid_email@example.com' }

        it 'does not add error' do
          expect(user).to be_valid
        end
      end

      context 'when format is not valid' do
        let(:email) { 'invalid_email' }

        it 'does not add error' do
          expect(user).not_to be_valid
          expect(user.errors[:email]).to include('is invalid')
        end
      end
    end
  end
end
