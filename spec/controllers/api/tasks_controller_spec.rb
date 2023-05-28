# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Tasks', type: :request do
  describe 'POST /api/tasks' do
    let(:project) { FactoryBot.create(:project) }
    let(:project_manager) { project.project_manager }
    let(:project_id) { project.id }
    let(:employee) { FactoryBot.create(:employee) }
    let(:employee_id) { employee.id }
    let(:valid_params) do
      {
        task: {
          title: title,
          description: description,
          work_focus: work_focus,
          due_date: due_date,
          project_id: project_id,
          employee_id: employee_id
        }
      }
    end
    let(:title) { 'Title' }
    let(:description) { 'description' }
    let(:work_focus) { Employee::DEVELOPMENT }
    let(:due_date) { Date.today.to_s }

    before do
      allow_any_instance_of(Api::TasksController).to receive(:current_user).and_return(project_manager)
    end

    context 'when the request is valid' do
      it 'creates a new task' do
        expect do
          post '/api/tasks', params: valid_params
        end.to change(Task, :count).by(1)
      end

      it 'returns the created task' do
        post '/api/tasks', params: valid_params

        expect(response).to have_http_status(:ok)
        task = JSON.parse(response.body)['task']
        expect(task['title']).to eq(title)
        expect(task['description']).to eq(description)
        expect(task['work_focus']).to eq(work_focus)
        expect(task['due_date']).to eq(due_date)
        expect(task['project_id']).to eq(project_id)
        expect(task['employee_id']).to eq(employee_id)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_params) do
        {
          task: {
            title: '',
            description: '',
            work_focus: '',
            due_date: '',
            project_id: '',
            employee_id: ''
          }
        }
      end

      it 'does not create a new task' do
        expect do
          post '/api/tasks', params: invalid_params
        end.not_to change(Task, :count)
      end

      it 'returns errors' do
        post '/api/tasks', params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to eq(['Project must exist', "Title can't be blank"])
      end
    end
  end
end
