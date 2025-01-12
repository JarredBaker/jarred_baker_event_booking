require 'rails_helper'

# bundle exec rspec ./spec/models/event_spec.rb

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:tickets) }
    it { should have_one(:location) }
  end

  describe 'columns' do
    it { should have_db_column(:id).of_type(:uuid) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:date).of_type(:datetime) }
    it { should have_db_column(:tickets_available).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:uuid) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'indexes' do
    it { should have_db_index(:date) }
    it { should have_db_index(:name) }
    it { should have_db_index(:user_id) }
    it { should have_db_index([:user_id, :date]) }
  end
end