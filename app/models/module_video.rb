class ModuleVideo < ApplicationRecord
  belongs_to :video
  belongs_to :training_module            
end