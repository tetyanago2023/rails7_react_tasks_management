# frozen_string_literal: true

class TaskUpdate
  attr_reader :task, :current_user, :params, :errors

  def initialize(task:, current_user:, params:)
    @task = task
    @current_user = current_user
    @params = params
    @errors = []
  end

  def call
    task.assign_attributes(attributes)
    assign_status

    task.save!
  rescue ActiveRecord::RecordNotSaved
    task.errors.full_messages.each do |error_message|
      errors.push(error_message)
    end
  end

  private

  def attributes
    @attributes ||= params.except(:id, :status, :project_id, :project_manager_id).to_h
  end

  def assign_status
    if done_status_assign? || employee_status_assign?
      task.status = task_status
    else
      errors.push('permission denied')
      raise ActiveRecord::RecordNotSaved
    end
  end

  def done_status_assign?
    task_status == Task::DONE && assigned_project_manager?
  end

  def employee_status_assign?
    [Task::NEEDS_REVIEW, Task::WORKING].include?(task_status) && assigned_employee?
  end

  def assigned_project_manager?
    task.project_manager == current_user
  end

  def assigned_employee?
    task.employee == current_user
  end

  def task_status
    @task_status ||= params[:status]
  end
end
