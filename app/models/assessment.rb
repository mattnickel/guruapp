class Assessment < ApplicationRecord
belongs_to :user
has_many :assessment_questions
# has_many :offered_responses, through: :assessment_questions
has_many :responses, through: :assessment_questions
end
    