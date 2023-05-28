# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  subject(:project) { FactoryBot.build(:project) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:project_manager) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:project_manager) }
    it { is_expected.to belong_to(:employee).optional }
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end
end
