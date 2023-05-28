# frozen_string_literal: true

class ExpireTaskJob
  include Sidekiq::Job

  def perform
    Task.where("status != 'done' AND due_date < :today", today: Date.today).update_all(status: Task::LATE)
  end
end
