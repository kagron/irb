class Document < ApplicationRecord

  mount_uploader :questions_file, QuestionsAttachmentUploader # Tells rails to use this uploader for this model.
  mount_uploader :consent_file, ConsentUploader # Tells rails to use this uploader for this model.
  mount_uploader :child_assent_file, ChildAssentUploader # Tells rails to use this uploader for this model.
  mount_uploader :hsr_certificate_file, HsrCertificateUploader # Tells rails to use this uploader for this model.
  mount_uploader :written_permission_file, WrittenPermissionUploader # Tells rails to use this uploader for this model.
  enum state: [:new_app, :approved, :rejected, :needs_revisions]
  enum typeOfApplication: [:standard, :expedited, :not_sure]
  enum is_archived: [:no, :yes]

  validates :fName, presence: true
  validates :lName, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :department, presence: true
  validates :typeOfApplication, presence: true
  validates :project_title, presence: true
  validates :sponsor_name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :research_question, presence: true
  validates :lit_review, presence: true
  validates :procedure, presence: true
  validates :pool_of_subjects, presence: true
  validates :sub_recruitment, presence: true
  #validates :risks, presence: true
  validates :opt_participation, presence: true
  validates :confidentiality, presence: true
  validates :authorities_consent, presence: true
  # validates :subjects_consent, presence: true
  #validates :parental_consent, presence: true
  validates :advisor_sig, presence: true
  validates :questions_file, presence: true
  validates :consent_file, presence: true
  validates :hsr_certificate_file, presence: true
  #validates :written_permission_file, presence: true
  belongs_to :user
  has_many :comments
  has_many :votes

  def self.search(search)
	where("id LIKE ? OR fName LIKE ? OR lName LIKE ? OR phone LIKE ? OR email LIKE ? OR department LIKE ? OR typeOfApplication LIKE ? OR project_title LIKE ? OR sponsor_name LIKE ? OR start_date LIKE ? OR end_date LIKE ? OR state LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end

end
