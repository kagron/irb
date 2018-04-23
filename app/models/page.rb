class Page < ApplicationRecord
  # Make sure these fields are present 
  validates :title, presence: true
  validates :content, presence: true
end
