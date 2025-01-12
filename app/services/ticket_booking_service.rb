class TicketBookingService
  def initialize(event_id:, user_id:, ticket_count:)
    @event_id = event_id
    @user_id = user_id
    @ticket_count = ticket_count.to_i
  end

  def call
    ActiveRecord::Base.transaction do
      broadcast_message("success", "Your ticket booking is being processed.")

      # Database level lock.
      event = Event.lock.find(@event_id)
      raise StandardError, "Not enough tickets available" if event.tickets_available < @ticket_count

      event.tickets_available -= @ticket_count
      event.save!

      @ticket_count.times do
        Ticket.create!(event_id: event.id, user_id: @user_id)
      end

      broadcast_message("success", "Your tickets for the event have been successfully booked!")
    end
  rescue StandardError => e
    Rails.logger.error("Ticket booking failed: #{e.message}")
    broadcast_message("failure", e.message)
    raise e
  end

  private

  def broadcast_message(status, message)
    ActionCable.server.broadcast "ticket_status_channel_#{@user_id}", {
      status: status,
      message: message
    }
  end
end
