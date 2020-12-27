FactoryBot.define do
  factory :moment do
    body { Faker::Lorem.sentence }
    track
  end
end

