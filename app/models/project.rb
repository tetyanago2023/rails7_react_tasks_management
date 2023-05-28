# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :project_manager
  belongs_to :employee, optional: true
  has_many :tasks, dependent: :destroy

  validates_presence_of :title, :project_manager
end
