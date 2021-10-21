class Response < ApplicationRecord
    belongs_to :user
    belongs_to :assessment
    belongs_to :question
    belongs_to :assessment_question
    has_many :offered_responses
end
