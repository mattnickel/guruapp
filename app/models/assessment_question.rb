class AssessmentQuestion < ApplicationRecord
    belongs_to :assessment
    has_many :questions
end
