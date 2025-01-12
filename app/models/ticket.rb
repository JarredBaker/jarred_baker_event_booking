class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :user_id, :event_id, presence: true

  after_commit :clear_ticket_cache

  private

  def clear_ticket_cache
    Rails.cache.delete("tickets/index")
  end
end
