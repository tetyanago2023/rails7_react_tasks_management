# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Projects', type: :request do
  let(:project_manager) { FactoryBot.create(:project_manager) }
  before do
    allow_any_instance_of(Api::ProjectsController).to receive(:current_user).and_return(project_manager)
  end

  describe 'GET /api/projects' do
    let!(:project1) { FactoryBot.create(:project, project_manager: project_manager) }
    let!(:project2) { FactoryBot.create(:project, project_manager: project_manager) }
    let!(:task1) { FactoryBot.create(:task, project_manager: project_manager, project: project1) }
    let!(:task2) { FactoryBot.create(:task, project_manager: project_manager, project: project2) }

    it 'returns a list of projects' do
      get '/api/projects'

      expect(response).to have_http_status(:ok)
      projects = JSON.parse(response.body)['projects']
      expect(projects[0]['id']).to eq(project2.id)
      expect(projects[0]['project_manager']['id']).to eq(project_manager.id)
      expect(projects[0]['employee']).to_not be_nil
      expect(projects[0]['tasks'][0]['id']).to eq(task2.id)
      expect(projects[1]['id']).to eq(project1.id)
      expect(projects[1]['project_manager']['id']).to eq(project_manager.id)
      expect(projects[1]['employee']).to_not be_nil
      expect(projects[1]['tasks'][0]['id']).to eq(task1.id)
    end
  end

  describe 'POST /api/projects' do
    let(:params) do
      {
        project: {
          title: title,
          description: description,
          due_date: due_date,
          employee_id: employee_id
        }
      }
    end
    let(:title) { 'Title' }
    let(:description) { 'Description' }
    let(:due_date) { Date.today.to_s }
    let(:employee) { FactoryBot.create(:employee) }
    let(:employee_id) { employee.id }

    context 'when the request is valid' do
      it 'creates a new project' do
        expect do
          post '/api/projects', params: params
        end.to change(Project, :count).by(1)
      end

      it 'returns the created project' do
        post '/api/projects', params: params

        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)['project']).to include(
                                                           'title' => title,
                                                           'description' => description,
                                                           'due_date' => due_date,
                                                           'employee_id' => employee_id
                                                         )
      end
    end

    context 'when the request is invalid' do
      let(:title) { '' }

      it 'does not create a new project' do
        expect do
          post '/api/projects', params: params
        end.not_to change(Project, :count)
      end

      it 'returns errors' do
        post '/api/projects', params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to eq(["Title can't be blank"])
      end
    end
  end
end
