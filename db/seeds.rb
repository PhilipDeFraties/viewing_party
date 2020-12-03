include FactoryBot::Syntax::Methods
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@user_1 = User.create!(email: 'whatever@email.com', password: 'password', password_confirmation: 'password', username: 'MovieWatcher1245')
@user_2 = create :user
@movie_1 = create :movie
@movie_2 = create :movie
@movie_3 = create :movie
@movie_4 = create :movie
@party_1 = Party.create!(user_id: @user_1.id, movie_id: @movie_1.id, date: '12-24-2020', time: '9:30')
@party_2 = Party.create!(user_id: @user_2.id, movie_id: @movie_2.id, date: '12-19-2020', time: '4:30')
@party_3 = Party.create!(user_id: @user_1.id, movie_id: @movie_3.id, date: '12-20-2020', time: '5:30')
@party_4 = Party.create!(user_id: @user_2.id, movie_id: @movie_4.id, date: '12-21-2020', time: '6:30')
PartyGuest.create!(user_id: @user_1.id, party_id: @party_2.id)
PartyGuest.create!(user_id: @user_1.id, party_id: @party_4.id)
