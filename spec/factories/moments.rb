FactoryBot.define do
  factory :moment do
    title { Faker::Name }
    body { Faker::Lorem.sentence }
    track
    original_date { Time.zone.now }
  end
end

