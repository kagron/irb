class Vote < ApplicationRecord
  # State is an integer field that we enumerate here
  enum state: [:new_app, :approved, :rejected, :needs_revisions]

  # Vote has a M:1 relationship with user and document
  belongs_to :user
  belongs_to :document
end
