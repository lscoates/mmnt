class Track < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :moments, -> { order(original_date: :desc) }

  # Validations
  validates_presence_of :user, :name
  validates_uniqueness_of :name,
    scope: :user_id,
    case_sensitive: false
end
