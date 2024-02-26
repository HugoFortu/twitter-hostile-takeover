# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.Production?
  puts "We never seed data in production"
  return
end

emojis_array = ["✌","😂","😝","😁","😱","👉","🙌","🍻","🔥","🌈","☀","🎈","🌹","💄","🎀","⚽","🎾","🏁","😡","👿","🐻","🐶","🐬","🐟","🍀","👀","🚗","🍎","💝","💙","👌","❤","😍","😉","😓","😳","💪","💩","🍸","🔑","💖","🌟","🎉","🌺","🎶","👠","🏈","⚾","🏆","👽","💀","🐵","🐮","🐩","🐎","💣","👃","👂","🍓","💘","💜","👊","💋","😘","😜","😵","🙏","👋","🚽","💃","💎","🚀","🌙","🎁","⛄","🌊","⛵","🏀","🎱","💰","👶","👸","🐰","🐷","🐍","🐫","🔫","👄","🚲","🍉","💛","💚"]
p "Create users"
elon = User.create(pseudo: "elon", email: "Elon@twxtter.com")
bruce = User.create(pseudo: "batman", email: "bruce@batman.com")
luffy = User.create(pseudo: "luffy", email: "luffy@mugiwara.com")
p "Users created"
users = [elon, bruce, luffy]
p "Create tweets"
first_tweet = Tweet.create(user_id: elon.id, content: "🚀👀🎊")
first_tweet.image.attach(io: File.open(Rails.root.join('db/images/elon.png')), filename: "elon.png")
counter = 1
14.times do
  content = ""
  (1..8).to_a.sample.times do
    content = content + emojis_array.sample
  end

  tweet = Tweet.create(user_id: users.sample.id, content: content)
  tweet.image.attach(io: File.open(Rails.root.join("db/images/random#{counter}.jpeg")), filename: "random#{counter}.jpeg")

  counter += 1
end

p "Tweets created"