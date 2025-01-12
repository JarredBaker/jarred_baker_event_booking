class Event < ApplicationRecord
  belongs_to :user
  has_one :location, as: :locatable, dependent: :destroy
  has_many :tickets, dependent: :destroy

  validates :name, :date, :tickets_available, presence: true
  validates :tickets_available, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates_associated :location

  accepts_nested_attributes_for :location

  after_commit :clear_event_cache

  private

  def clear_event_cache
    Rails.cache.delete("events/index")
  end
end
