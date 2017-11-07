class Document < ApplicationRecord
  enum state: [:new_app, :approved, :rejected, :needs_revisions, :archived]
  enum typeOfApplication: [:standard, :expedited, :not_sure]
end
