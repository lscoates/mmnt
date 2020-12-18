class Track < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates_uniqueness_of :name, scope: :user_id
  validates_presence_of :user
end
