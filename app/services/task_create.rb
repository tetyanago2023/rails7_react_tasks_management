# frozen_string_literal: true

class TaskCreate
  attr_reader :current_user, :params, :task, :errors

  def initialize(current_user:, params:)
    @current_user = current_user
    @params = params
    @errors = []
  end

  def call
    @task = Task.new(params.merge({ project_manager: current_user }))
    @task.save!
  rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid
    @task.errors.full_messages.each do |error_message|
      errors.push(error_message)
    end
  end
end
