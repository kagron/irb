class Document < ApplicationRecord
  mount_uploader :questions_file, QuestionsAttachmentUploader # Tells rails to use this uploader for this model.
  enum state: [:new_app, :approved, :rejected, :needs_revisions]
  enum typeOfApplication: [:standard, :expedited, :not_sure]
  enum is_archived: [:yes, :no]
end
