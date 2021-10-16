class OfferedResponse < ApplicationRecord
    has_and_belongs_to_many :question
    # belongs_to :response
end
