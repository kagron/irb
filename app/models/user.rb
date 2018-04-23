class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # Before you create a user, make sure certain fields are set
  before_create :default_action
  # link this user to the Devise gem which handles
  # the whole user registrations, profiles, validation, etc etc
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # User has a 1:M relationship with documents, comments, and votes
  has_many :documents
  has_many :comments
  has_many :votes
  # We use the searchkick gem to use ElasticSearch appropriately
  # this gets used in the /board action
  searchkick text_start: ['first_name', 'last_name']

  private
  # I think this action doesn't work and we fixed it with a migration but I don't want to comment
  # it out and test
    def default_action
      self.supervisor_role = false
      self.superadmin_role = false
      self.readonly_role = false
    end
end
