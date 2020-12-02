FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password  { 'password' }
    password_confirmation  { 'password' }
    username { Faker::Name.name  }
  end
end
