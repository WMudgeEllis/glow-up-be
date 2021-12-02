user = User.create!(
  username: 'User',
  password: 'hello',
  password_confirmation: 'hello'
)

(1..10).to_a.each do |num|
  Mood.create!(
    mood: [1, 2, 3, 4, 5].sample,
    description: "Mood #{num}",
    user_id: user.id
  )
end
