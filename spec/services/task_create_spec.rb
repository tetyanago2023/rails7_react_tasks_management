# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskCreate do
  describe '#call' do
    subject { described_class.new(current_user: current_user, params: params) }

    let(:params) do
      {
        title: title,
        description: 'Description',
        work_focus: 'development',
        due_date: Date.today.to_s,
        project_id: project_id,
        employee_id: employee_id,
        parent_task_id: parent_task_id
      }
    end
    let(:project) { FactoryBot.create(:project) }
    let(:current_user) { project.project_manager }
    let(:project_id) { project.id }
    let(:employee) { project.employee }
    let(:employee_id) { employee.id }
    let!(:parent_task) do
      FactoryBot.create(:task, project: project, project_manager: project.project_manager, employee: employee)
    end
    let(:parent_task_id) { parent_task.id }

    context 'when task creation is successful' do
      let(:title) { 'Title' }

      it 'creates Task' do
        expect { subject.call }.to change { Task.all.reload.count }.by(1)
      end
    end

    context 'when task creation fails' do
      let(:title) { nil }

      it 'adds validation error' do
        subject.call
        expect(subject.errors).to include("Title can't be blank")
      end
    end
  end
end
