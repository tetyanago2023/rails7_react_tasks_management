# frozen_string_literal: true

class Task < ApplicationRecord
  STATUSES = [
    NOT_STARTED = 'not_started',
    WORKING = 'working',
    NEEDS_REVIEW = 'needs_review',
    DONE = 'done',
    LATE = 'late'
  ].freeze

  EMPLOYEE_STATUSES = [NOT_STARTED, WORKING, NEEDS_REVIEW].freeze

  enum status: STATUSES.zip(STATUSES).to_h
  enum work_focus: Employee::WORK_FOCUSES.zip(Employee::WORK_FOCUSES).to_h

  belongs_to :project_manager
  belongs_to :employee, optional: true
  belongs_to :parent_task, class_name: 'Task', optional: true
  belongs_to :project

  has_many :subtasks, class_name: 'Task', foreign_key: 'parent_task_id', dependent: :destroy

  validates_presence_of :title, :project_manager

  def sub_tasks
    self.class.where(parent_task_id: id)
  end
end
