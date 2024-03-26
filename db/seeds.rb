# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
%w[foobar1 foobar2 foobar3 foobar4 foobar5 foobar6].each do |l|
  User.create(email: "#{l}@foobar.com",
              password: 'password',
              password_confirmation: 'password',
              first_name: l.capitalize,
              last_name: l.capitalize)
end

User.all.each do |user|
  uri = 'https://i.kym-cdn.com/entries/icons/mobile/000/027/424/joke.jpg'
  user.avatar.attach(io: URI.parse(uri).open, filename: "profile.#{uri.split('.').last}")
end

50.times do
  Post.create(user_id: rand(1..6), content: Array('a'..'z').sample(14).join)
end
