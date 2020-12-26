FactoryBot.define do
  factory :track do
    name { Faker::Name.first_name }
    user
  end
end

