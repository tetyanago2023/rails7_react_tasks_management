# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Employees', type: :request do
  describe 'GET /api/employees' do
    let!(:employee1) { FactoryBot.create(:employee) }
    let!(:employee2) { FactoryBot.create(:employee) }

    it 'returns a list of employees' do
      get '/api/employees'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['employees']).to contain_exactly(
        employee2.as_json,
        employee1.as_json
      )
    end
  end

  describe 'POST /api/employees' do
    let(:project_manager) { FactoryBot.create(:project_manager) }
    let(:valid_params) do
      {
        employee: {
          email: 'john@example.com',
          name: 'John Doe',
          title: 'Software Engineer',
          work_focus: Employee::DEVELOPMENT
        }
      }
    end

    before do
      allow_any_instance_of(Api::EmployeesController).to receive(:current_user).and_return(project_manager)
    end

    context 'when the request is valid' do
      it 'creates a new employee' do
        expect do
          post '/api/employees', params: valid_params
        end.to change(Employee, :count).by(1)
      end

      it 'returns the created employee' do
        post '/api/employees', params: valid_params

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['employee']).to include(
          'email' => 'john@example.com',
          'name' => 'John Doe',
          'title' => 'Software Engineer',
          'work_focus' => Employee::DEVELOPMENT
        )
      end
    end

    context 'when the request is invalid' do
      let(:invalid_params) do
        {
          employee: {
            email: '',
            name: '',
            title: '',
            work_focus: ''
          }
        }
      end

      it 'does not create a new employee' do
        expect do
          post '/api/employees', params: invalid_params
        end.not_to change(Employee, :count)
      end

      it 'returns errors' do
        post '/api/employees', params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to eq([
                                                            "Email can't be blank",
                                                            'Email is invalid',
                                                            "Name can't be blank",
                                                            "Title can't be blank",
                                                            "Work focus can't be blank"
                                                          ])
      end
    end
  end
end
