User.destroy_all
Journal.destroy_all
JournalEntry.destroy_all

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

j = Journal.create!(name: 'daily', details: 'J')

j.journal_entries.create!(date: Date.today, content: 'JJJJJJJJ', user_id: User.first.id)
j.journal_entries.create!(date: Date.today, content: 'AAAAAAAA', user_id: User.last.id)

h = Habit.create!(name: 'h1', description: 'd1')

h.habit_entries.create!(date: Date.today, status: 1, user_id: User.first.id, habit_id: h.id)
