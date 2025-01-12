class Location < ApplicationRecord
  belongs_to :locatable, polymorphic: true

  validates :address, presence: true

  # Geocoding
  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address.present? && obj.address_changed? }

  def full_coordinates
    "#{latitude}, #{longitude}"
  end
end
