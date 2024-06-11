class Job < ApplicationRecord
    belongs_to :recruiter
    has_many :submissions
    validates :title, :description, :recruiter_id, presence: true
  end