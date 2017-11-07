class Document < ApplicationRecord
  enum state: [:new_app, :approved, :rejected, :needs_revisions]
  enum typeOfApplication: [:standard, :expedited, :not_sure]
  enum is_archived: [:yes, :no]
end
