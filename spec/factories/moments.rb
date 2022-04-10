FactoryBot.define do
  factory :moment do
    title { Faker::Name }
    content { Faker::Lorem.sentence }
    track
    original_date { Time.zone.now }
  end
end

