# frozen_string_literal: true

class Employee < User
  WORK_FOCUSES = [
    DEVELOPMENT = 'development',
    DESIGN = 'design',
    BUSINESS = 'business',
    RESEARCH = 'research',
    OTHER = 'other'
  ].freeze

  validates_presence_of :title, :work_focus

  enum work_focus: WORK_FOCUSES.zip(WORK_FOCUSES).to_h

  has_many :projects, dependent: :nullify
  has_many :tasks, dependent: :nullify
end
