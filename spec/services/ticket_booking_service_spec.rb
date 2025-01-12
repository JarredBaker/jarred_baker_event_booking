require 'rails_helper'

# bundle exec rspec ./spec/services/ticket_booking_service_spec.rb

RSpec.describe TicketBookingService, type: :service do
  let!(:event) { create(:event, tickets_available: 10) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  describe '#call' do
    context 'when multiple users book tickets at the same time' do
      it 'ensures tickets are booked correctly and no overselling occurs' do
        threads = []
        results = []

        # User 1 attempts to book 6 tickets
        threads << Thread.new do
          service = TicketBookingService.new(event_id: event.id, user_id: user1.id, ticket_count: 6)
          begin
            service.call
            results << { user: user1.id, success: true }
          rescue StandardError => e
            results << { user: user1.id, success: false, error: e.message }
          end
        end

        # User 2 attempts to book 6 tickets
        threads << Thread.new do
          service = TicketBookingService.new(event_id: event.id, user_id: user2.id, ticket_count: 6)
          begin
            service.call
            results << { user: user2.id, success: true }
          rescue StandardError => e
            results << { user: user2.id, success: false, error: e.message }
          end
        end

        threads.each(&:join)

        # Ensure the total tickets booked do not exceed the available tickets
        expect(event.reload.tickets_available).to be == 4
        expect(event.tickets.count).to eq(6) # Total tickets created
        expect(event.tickets.where(user_id: user1.id).count).to be <= 6
        expect(event.tickets.where(user_id: user2.id).count).to be <= 6

        failed_booking = results.find { |result| result[:success] == false }
        expect(failed_booking).not_to be_nil
        expect(failed_booking[:error]).to match(/Not enough tickets available/)
      end
    end
  end
end
