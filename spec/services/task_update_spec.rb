# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskUpdate do
  describe '#call' do
    subject { described_class.new(task: task, current_user: current_user, params: params) }

    let(:task) { FactoryBot.create(:task) }
    let(:params) do
      {
        title: title,
        description: 'Description',
        work_focus: 'development',
        due_date: Date.today.to_s,
        status: status,
        employee_id: employee_id,
      }
    end
    let(:title) { 'Title' }

    let(:current_user) { task.project_manager }
    let(:employee) { FactoryBot.create(:employee) }
    let(:employee_id) { employee.id }

    context 'when task update is successful' do

      context 'when current_user is ProjectManager' do
        let(:status) { Task::DONE }

        it 'updates status to done' do
          expect { subject.call }.to change { task.reload.status }.from(Task::NOT_STARTED).to(Task::DONE)
        end
      end

      context 'when current_user is Employee' do
        let(:status) { Task::WORKING }
        let(:current_user) { employee }

        it 'updates status to working' do
          expect { subject.call }.to change { task.reload.status }.from(Task::NOT_STARTED).to(Task::WORKING)
        end
      end
    end

    context 'when task update fails' do
      context 'when current_user is ProjectManager' do
        let(:status) { Task::WORKING }

        it 'adds validation error' do
          expect { subject.call }.to_not(change { task.reload.title })
          expect(subject.errors).to include('permission denied')
        end
      end

      context 'when current_user is Employee' do
        let(:status) { Task::DONE }
        let(:current_user) { employee }

        it 'adds validation error' do
          expect { subject.call }.to_not(change { task.reload.title })
          expect(subject.errors).to include('permission denied')
        end
      end
    end
  end
end
