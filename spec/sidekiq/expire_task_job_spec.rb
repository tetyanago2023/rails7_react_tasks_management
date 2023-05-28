# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpireTaskJob, type: :job do
  describe '#perform' do
    let(:today) { Date.today }
    let!(:overdue_task) { FactoryBot.create(:task, status: Task::WORKING, due_date: today - 1.day) }
    let!(:done_task) { FactoryBot.create(:task, status: Task::DONE, due_date: today - 1.day) }
    let!(:future_task) { FactoryBot.create(:task, status: Task::WORKING, due_date: today + 1.day) }

    it "updates overdue_task 'late' status" do
      expect { ExpireTaskJob.new.perform }.to change { overdue_task.reload.status }.from(Task::WORKING).to(Task::LATE)
    end

    it 'does not update done_task' do
      expect { ExpireTaskJob.new.perform }.to_not(change { done_task.reload.status })
    end

    it 'does not update future_task' do
      expect { ExpireTaskJob.new.perform }.to_not(change { future_task.reload.status })
    end
  end
end
