class Moment < ApplicationRecord
  has_rich_text :content

  # Associations
  belongs_to :track
  has_one_attached :feature_image

  # Validations
  validates_presence_of :title, :content, :track, :original_date
  validates :feature_image, content_type: ["image/png", "image/jpg", "image/jpeg"]

  # Callbacks
  before_validation :set_original_date

  private

  def set_original_date
    self.original_date ||= Time.zone.now
  end
end
