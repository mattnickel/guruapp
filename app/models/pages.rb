class Marketing < ApplicationRecord
	has_one_attached :hero_image
	has_one_attached :section_p1_image
    has_one_attached :section_p2_image
    has_one_attached :section_p3_image
end
