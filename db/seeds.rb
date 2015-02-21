# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |n|
  User.create(email: "example#{n}@mail.com", password: "12345678")
end

2.times do |n|
  Group.create(name: "Group#{n}")
end

User.all.each do |user|
  Membership.create(group_id: Group.first.id, user_id: user.id)
  Membership.create(group_id: Group.last.id, user_id: user.id)
end
