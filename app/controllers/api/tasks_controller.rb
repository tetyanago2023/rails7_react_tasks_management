# frozen_string_literal: true

module Api
  class TasksController < ApplicationController
    before_action :check_project_manager, only: [:create]

    def create
      service = ::TaskCreate.new(current_user:, params: tasks_create_params)
      service.call
      if service.errors.present?
        render json: { errors: service.errors }, status: :unprocessable_entity
      else
        render json: { task: service.task.as_json }, status: :ok
      end
    end

    def update
      service = ::TaskUpdate.new(task:, current_user:, params: tasks_update_params)
      service.call
      if service.errors.present?
        render json: { errors: service.errors }, status: :unprocessable_entity
      else
        render json: { task: task.as_json }, status: :ok
      end
    end

    private

    def task
      @task = Task.find(params[:id])
    end

    def tasks_create_params
      params.require(:task)
            .permit(:title, :description, :work_focus, :due_date, :project_id, :employee_id, :parent_task_id)
    end

    def tasks_update_params
      params.require(:task).permit(:title, :description, :work_focus, :due_date, :status, :employee_id)
    end
  end
end
