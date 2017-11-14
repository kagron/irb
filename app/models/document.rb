class Document < ApplicationRecord
  mount_uploader :questions_file, QuestionsAttachmentUploader # Tells rails to use this uploader for this model.
  mount_uploader :consent_file, ConsentUploader # Tells rails to use this uploader for this model.
  mount_uploader :child_assent_file, ChildAssentUploader # Tells rails to use this uploader for this model.
  mount_uploader :hsr_certificate_file, HsrCertificateUploader # Tells rails to use this uploader for this model.
  mount_uploader :written_permission_file, WrittenPermissionUploader # Tells rails to use this uploader for this model.
  enum state: [:new_app, :approved, :rejected, :needs_revisions]
  enum typeOfApplication: [:standard, :expedited, :not_sure]
  enum is_archived: [:no, :yes]
  
  
  def self.search(search)
	where("fName LIKE ? OR lName LIKE ?", "%#{search}%", "%#{search}%")
  end
end
