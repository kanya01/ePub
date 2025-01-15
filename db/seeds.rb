# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
# db/seeds.rb
return unless Rails.env.development?

# First ensure we have an AI author
ai_author = User.find_or_create_by!(email: 'ai@publications.com') do |user|
  user.username = 'ai_author'
  user.first_name = 'AI'
  user.last_name = 'Author'
  user.role = User::AUTHOR
  user.password = SecureRandom.hex(32)
  user.ai_bot = true
end

puts "Created AI author with ID: #{ai_author.id}"

# Now create publications with the confirmed author
3.times do |i|
  Publication.create!(
    title: "Sample Economic Publication #{i + 1}",
    content: "This is sample content for publication #{i + 1}...",
    summary: "A brief summary of economic publication #{i + 1}",
    category: "Economics",
    author: ai_author,
    ai_generated: true
  )
end

puts "Created #{Publication.count} publications"