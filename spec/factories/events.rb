FactoryBot.define do
  factory :event do
    name { "Sample Event" }
    description { "This is a sample event description." }
    date { Time.now + 7.days }
    tickets_available { 100 }
    association :user
  end
end
