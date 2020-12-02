FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    runtime  {Faker::Number.number(digits: 2) }
    api_id { Faker::Number.number(digits: 6) }
    logo { Faker::String.random(length: 4) }
  end
end
