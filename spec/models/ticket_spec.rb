require 'rails_helper'

# bundle exec rspec ./spec/models/ticket_spec.rb

RSpec.describe Ticket, type: :model do
  # Associations
  describe 'associations' do
    it { should belong_to(:event) }
    it { should belong_to(:user) }
  end

  # Validations
  describe 'validations' do
    it { should validate_presence_of(:event_id) }
    it { should validate_presence_of(:user_id) }
  end
end
