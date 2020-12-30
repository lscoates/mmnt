class Moment < ApplicationRecord
  # Associations
  belongs_to :track

  # Validations
  validates_presence_of :title, :body, :track, :original_date

  # Callbacks
  before_validation :set_original_date

  private

  def set_original_date
    self.original_date ||= Time.zone.now
  end
end
