class AssessmentQuestion < ApplicationRecord
    belongs_to :assessment
    has_many :questions
    # has_many :offered_responses, through: :questions
    has_many :responses
end
