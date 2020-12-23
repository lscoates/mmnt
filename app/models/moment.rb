class Moment < ApplicationRecord
  # Associations
  belongs_to :track

  # Validations
  validates_presence_of :body, :track
end
