require 'faker'

puts "clear database..."

Message.destroy_all
Topic.destroy_all
User.destroy_all

puts "database cleared !"

puts "create some users and topics..."

10.times do
  nickname = Faker::Internet.username
  user = User.create(
    email: "#{nickname}@gmail.com",
    password: Faker::Internet.password(min_length: 12),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    nickname: nickname
  )

  nickname = Faker::Internet.username
  Topic.create(
    user: user,
    title: "Lorem #{User.count}",
    description: 'Lorem ipsum dolor, sit amet consectetur, adipisicing elit. Consectetur rerum, velit ab dolorem, quisquam natus inventore architecto recusandae provident! Non maiores nam mollitia perferendis veniam totam repudiandae eius a recusandae'
  )
end

puts "#{User.count} users created !"
puts "#{Topic.count} topics created !"

puts "create some messages..."

10.times do |i|
  Message.create(
    user: User.last,
    topic: Topic.all[i - 1],
    content: 'Lorem ipsum'
  )
end

puts "#{Message.count} messages created !"
