# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :name, :type

  has_secure_password

  def project_manager?
    type == 'ProjectManager'
  end
end
