class Document < ApplicationRecord
  # befor you validate the document, set its default values
  before_validation :default_action

  # This is what allows a user to upload files to their application
  # You link an uploader to a field in the table and then store the files location
  # in that field
  mount_uploader :questions_file, QuestionsAttachmentUploader # Tells rails to use this uploader for this model.
  mount_uploader :consent_file, ConsentUploader # Tells rails to use this uploader for this model.
  mount_uploader :child_assent_file, ChildAssentUploader # Tells rails to use this uploader for this model.
  mount_uploader :hsr_certificate_file, HsrCertificateUploader # Tells rails to use this uploader for this model.
  mount_uploader :written_permission_file, WrittenPermissionUploader # Tells rails to use this uploader for this model.

  # state and type of application are both integer fields that we enumerate here
  # and can add various states or types without modifying the database
  enum state: [:new_app, :approved, :rejected, :needs_revisions]
  enum typeOfApplication: [:standard, :expedited, :not_sure]

  # When creating an application, make sure that these fields are present before submitting
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
  # validates :consent_file, presence: true
  validates :hsr_certificate_file, presence: true
  # validates :written_permission_file, presence: true
  # validates :child_assent_file, presence: true

  # Document has a M:1 relationship with User
  # Document has a 1:M relationship with comments, votes, and assignments
  belongs_to :user
  has_many :comments
  has_many :votes
  has_many :assignments

  # this is what we use when calling the search method
  # this can probably be replaced with elasticsearch but we ran out of time
  def self.search(search)
	where("id LIKE ? OR fName LIKE ? OR lName LIKE ? OR phone LIKE ? OR email LIKE ? OR department LIKE ? OR typeOfApplication LIKE ? OR project_title LIKE ? OR sponsor_name LIKE ? OR start_date LIKE ? OR end_date LIKE ? OR state LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  private
  # I think this action is a failed attempt at setting defaults, we just used a migration to fix this issue
    def default_action
      self.is_archived = false if self.is_archived.nil?
      return true
    end

end
