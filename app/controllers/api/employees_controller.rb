# frozen_string_literal: true

module Api
  class EmployeesController < ApplicationController
    before_action :check_project_manager, only: [:create]

    def index
      @employees = Employee.all.order('created_at DESC')
      render json: { employees: @employees.as_json }, status: :ok
    end

    def create
      service = ::EmployeeCreate.new(params: employee_params)
      service.call
      if service.errors.present?
        render json: { errors: service.errors }, status: :unprocessable_entity
      else
        render json: { employee: service.employee.as_json }, status: :ok
      end
    end

    private

    def employee_params
      params.require(:employee).permit(:email, :name, :title, :work_focus)
    end
  end
end
