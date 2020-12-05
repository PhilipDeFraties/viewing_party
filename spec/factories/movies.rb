FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    runtime  { 90 }
    api_id { Faker::Number.unique.number(digits: 4) }
    logo { "/astKJpagcTTqybiAZ6qpakVqmow.jpg" }
  end
end
