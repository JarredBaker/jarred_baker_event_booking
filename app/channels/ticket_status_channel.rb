class TicketStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ticket_status_channel_#{params[:user_id]}"
  end

  def unsubscribed
    stop_all_streams
  end
end