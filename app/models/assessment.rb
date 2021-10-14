class Assessment < ApplicationRecord

# enum assessment_type: [:graded, :nongraded]
has_many :assessment_questions
end
