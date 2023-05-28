# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    due_date { Faker::Date.forward }
    project_manager { association(:project_manager) }
    employee { association(:employee) }
  end
end
