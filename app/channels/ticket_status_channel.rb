class TicketStatusChannel < ApplicationCable::Channel
  def subscribed
    user_id = params[:user_id]
    stream_from "ticket_status_channel_#{user_id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end