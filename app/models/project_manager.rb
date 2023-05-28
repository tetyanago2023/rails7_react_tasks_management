# frozen_string_literal: true

class ProjectManager < User
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :nullify
end
