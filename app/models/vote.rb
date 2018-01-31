class Vote < ApplicationRecord
  enum state: [:new_app, :approved, :rejected, :needs_revisions]

  belongs_to :user
  belongs_to :document
end
