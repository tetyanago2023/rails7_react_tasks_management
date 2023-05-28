# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  subject(:task) { FactoryBot.build(:task) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:project_manager) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:project_manager) }
    it { is_expected.to belong_to(:employee).optional }
    it { is_expected.to belong_to(:parent_task).class_name('Task').optional }
    it { is_expected.to have_many(:subtasks).class_name('Task').with_foreign_key('parent_task_id').dependent(:destroy) }
  end

  describe '#sub_tasks' do
    let(:parent_task) { FactoryBot.create(:task) }
    let!(:sub_task1) { FactoryBot.create(:task, parent_task_id: parent_task.id) }
    let!(:sub_task2) { FactoryBot.create(:task, parent_task_id: parent_task.id) }
    let!(:other_task) { FactoryBot.create(:task) }

    it 'returns an ActiveRecord relation of sub tasks' do
      expect(parent_task.sub_tasks).to be_an(ActiveRecord::Relation)
    end

    it 'returns all sub tasks associated with the parent task' do
      expect(parent_task.sub_tasks).to match_array([sub_task1, sub_task2])
    end

    it 'does not include tasks that are not sub tasks of the parent task' do
      expect(parent_task.sub_tasks).not_to include(other_task)
    end
  end
end
