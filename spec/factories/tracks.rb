FactoryBot.define do
  factory :track do
    name { Faker::Mountain.name }
    user
  end
end

