# frozen_string_literal: true

FactoryBot.define do
  factory :employee, parent: :user, class: 'Employee' do
    title { Faker::Job.title }
    work_focus { Employee::DEVELOPMENT }
    type { 'Employee' }
  end
end
