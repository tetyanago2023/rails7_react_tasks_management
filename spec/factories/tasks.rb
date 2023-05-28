# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    work_focus { Employee::DEVELOPMENT }
    due_date { Faker::Date.forward }
    status { Task::NOT_STARTED }
    project_manager { association(:project_manager) }
    project { association(:project, project_manager:) }
    employee { association(:employee) }
  end
end
