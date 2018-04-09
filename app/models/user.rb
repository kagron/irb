class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  before_create :default_action
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :documents
  has_many :comments
  has_many :votes
  searchkick text_start: ['first_name', 'last_name']

  private
    def default_action
      self.supervisor_role = 'false'
      self.superadmin_role = 'false'
      self.readonly_role = 'false'
    end
end
