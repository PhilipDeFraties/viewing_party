FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    runtime  { 90 }
    api_id { 123456 }
    logo { Faker::LoremFlickr.image(size: "50x60") }
  end
end
