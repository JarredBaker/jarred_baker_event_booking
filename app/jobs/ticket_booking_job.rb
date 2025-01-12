class TicketBookingJob < ApplicationJob
  queue_as :default

  def perform(event_id, user_id, ticket_count)
    TicketBookingService.new(event_id: event_id, user_id: user_id, ticket_count: ticket_count).call
  rescue StandardError => e
    Rails.logger.error("Job failed: #{e.message}")
    raise e
  end
end
