# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = [
  { name: "Ava Khan", email: "ava@example.com", age: 29, is_active: true },
  { name: "Noah Lee", email: "noah@example.com", age: 34, is_active: true },
  { name: "Mia Patel", email: "mia@example.com", age: 26, is_active: false },
]

users.each do |attrs|
  User.find_or_create_by!(email: attrs[:email]) { |u| u.assign_attributes(attrs) }
end

User.find_each do |user|
  2.times do |i|
    Post.find_or_create_by!(user: user, title: "Post #{i + 1} by #{user.name}") do |post|
      post.body = "Sample content for #{user.name}'s post #{i + 1}."
      post.published = i.even?
    end
  end
end

Post.find_each do |post|
  User.where.not(id: post.user_id).limit(2).each do |commenter|
    Comment.find_or_create_by!(post: post, user: commenter) do |comment|
      comment.body = "Comment by #{commenter.name} on #{post.title}."
    end
  end
end
