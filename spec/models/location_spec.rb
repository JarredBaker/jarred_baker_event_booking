require 'rails_helper'

# bundle exec rspec ./spec/models/location_spec.rb

RSpec.describe Location, type: :model do
  # Columns
  describe 'columns' do
    it { should have_db_column(:id).of_type(:uuid) }
    it { should have_db_column(:address).of_type(:string) }
    it { should have_db_column(:latitude).of_type(:float) }
    it { should have_db_column(:longitude).of_type(:float) }
    it { should have_db_column(:locatable_type).of_type(:string) }
    it { should have_db_column(:locatable_id).of_type(:uuid) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  # Associations
  describe 'associations' do
    it { should belong_to(:locatable) }
  end

  # Validations
  describe 'validations' do
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:locatable_type) }
    it { should validate_presence_of(:locatable_id) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
    it { should allow_value('1600 Amphitheatre Parkway, Mountain View, CA').for(:address) }
    it { should_not allow_value(nil).for(:address) }
  end

  # Geocoder functionality
  describe 'geocoding' do
    let(:location) { build(:location, address: '1600 Amphitheatre Parkway, Mountain View, CA') }

    it 'geocodes latitude and longitude when address is provided' do
      location.valid?
      expect(location.latitude).not_to be_nil
      expect(location.longitude).not_to be_nil
    end

    it 'does not geocode if address has not changed' do
      location.save
      original_latitude = location.latitude
      original_longitude = location.longitude

      location.update(address: location.address)
      expect(location.latitude).to eq(original_latitude)
      expect(location.longitude).to eq(original_longitude)
    end
  end

  describe 'custom methods' do
    let(:location) { build(:location, latitude: 37.4224764, longitude: -122.0842499) }

    describe '#full_coordinates' do
      it 'returns latitude and longitude as a string' do
        expect(location.full_coordinates).to eq('37.4224764, -122.0842499')
      end
    end
  end
end