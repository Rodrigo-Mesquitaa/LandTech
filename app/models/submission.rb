class Submission < ApplicationRecord
    belongs_to :job
    validates :name, :email, :job_id, presence: true
    validates :email, uniqueness: { scope: :job_id, message: "Você já se candidatou a essa vaga" }
  end