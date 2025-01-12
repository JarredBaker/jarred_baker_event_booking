class EventsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    return @events.includes(:location).all unless Rails.application.config.cache_classes && Rails.env.development?
    @events = Rails.cache.fetch("events/index", expires_in: 12.hours) do
      Event.includes(:location).to_a
    end
  end

  def view_own
    @events = Event.where(user_id: current_user.id)
  end

  def new
    @event = Event.new
  end

  def show; end

  def create
    @event = current_user.events.build(create_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def create_params
    params.require(:event).permit(
      :name,
      :description,
      :date,
      :tickets_available,
      location_attributes: [
        :address
      ]
    )
  end
end
