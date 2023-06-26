# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
unless Admin.find_by(email: 'admin@gmail.com')
  Admin.create!(
     email: 'admin@gmail.com',
     password: 'testtest'
  )
end

10.times do |n|
  EndUser.create!(
    email: "test#{n + 1}@test.com",
    nick_name: "テストユーザー#{n + 1}",
    date_of_birth: "1960-6-1",
    password: "testhoge"
  )
end

10.times do |n|
  Post.create!(
    end_user_id: "#{n + 1}",
    title: "test.title#{n + 1}",
    body: "test.body#{n + 1}"
  )
end

10.times do |n|
  ChatRoom.create!(
    end_user_id: "#{n + 1}",
    title: "test.title#{n + 1}",
    introduction: "test.introduction#{n + 1}"
  )
end

Relationship.create!(
  follower_id: 2,
  followed_id: 1
  )
  
Relationship.create!(
  follower_id: 3,
  followed_id: 1
  )

Relationship.create!(
  follower_id: 1,
  followed_id: 2
  )
  
Relationship.create!(
  follower_id: 1,
  followed_id: 3
  )