require 'rails_helper'

# bundle exec rspec ./spec/models/ticket_spec.rb

RSpec.describe Ticket, type: :model do
  # Associations
  describe 'associations' do
    it { should belong_to(:event) }
    it { should belong_to(:user) }
  end

  # Columns
  describe 'columns' do
    it { should have_db_column(:id).of_type(:uuid) }
    it { should have_db_column(:user_id).of_type(:uuid) }
    it { should have_db_column(:event_id).of_type(:uuid) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  # Validations
  describe 'validations' do
    it { should validate_presence_of(:event_id) }
    it { should validate_presence_of(:user_id) }
  end
end
