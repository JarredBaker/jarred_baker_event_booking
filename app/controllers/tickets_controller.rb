class TicketsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index; end

  def create
    TicketBookingJob.perform_later(create_params[:event_id], current_user.id, params[:ticket_count])
    flash[:notice] = "Your ticket booking is being processed."
    redirect_to event_path(create_params[:event_id])
  rescue StandardError => e
    flash[:alert] = "Failed to book tickets: #{e.message}"
  end

  private

  def create_params
    params.permit(
      :event_id,
    )
  end
end