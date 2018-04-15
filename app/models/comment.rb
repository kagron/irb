class Comment < ApplicationRecord
  # Comment has a M:1 relationship with user and document 
  belongs_to :user
  belongs_to :document
end
