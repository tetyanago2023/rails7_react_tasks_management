# frozen_string_literal: true

class EmployeeCreate
  attr_reader :params, :employee, :errors

  def initialize(params:)
    @params = params
    @errors = []
  end

  def call
    @employee = Employee.new(attributes)
    @employee.save!
  rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid
    @employee.errors.full_messages.each do |error_message|
      errors.push(error_message)
    end
  end

  private

  def attributes
    params.to_h.merge({ password: ENV['DEFAULT_PASSWORD'], password_confirmation: ENV['DEFAULT_PASSWORD'] })
  end
end
