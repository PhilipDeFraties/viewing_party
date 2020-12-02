FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest  { Faker::String.random(length: 4) }
    username { Faker::Name.name  }
  end
end
