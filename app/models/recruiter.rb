class Recruiter < ApplicationRecord
    has_secure_password
    has_many :jobs
    validates :name, :email, presence: true
  end