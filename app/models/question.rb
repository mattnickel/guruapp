class Question < ApplicationRecord
    has_and_belongs_to_many :assessment_questions
    has_many :offered_responses
end


