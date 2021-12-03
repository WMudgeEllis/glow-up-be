User.destroy_all
Journal.destroy_all
JournalEntry.destroy_all
Habit.destroy_all
HabitEntry.destroy_all

user = User.create!(
  username: 'User',
  password: 'hello',
  password_confirmation: 'hello'
)

(1..30).to_a.each do |num|
  Mood.create!(
    mood: [0, 1, 2, 3, 4].sample,
    description: "Mood #{num}",
    user_id: user.id,
    created_at: Date.today - num
  )
end

j = Journal.create!(name: 'daily', details: 'J')

(1..30).to_a.each do |num|
  JournalEntry.create!(
    date: Date.today - num,
    content: 'something really important',
    user_id: User.first.id,
    journal: j
  )
end

h1 = Habit.create!(name: 'h1', description: 'd1')
h2 = Habit.create!(name: 'h2', description: 'd2')
h3 = Habit.create!(name: 'h3', description: 'd3')
h4 = Habit.create!(name: 'h4', description: 'd4')
h5 = Habit.create!(name: 'h5', description: 'd5')
h6 = Habit.create!(name: 'h6', description: 'd6')
h7 = Habit.create!(name: 'h7', description: 'd7')
h8 = Habit.create!(name: 'h8', description: 'd8')
h9 = Habit.create!(name: 'h9', description: 'd9')
h10 = Habit.create!(name: 'h10', description: 'd10')



(1..30).to_a.each do |num|
  h1.habit_entries.create!(
    status: [0, 1].sample,
    user_id: User.first.id,
    habit_id: h1.id
  )
end

(1..17).to_a.each do |num|
  h2.habit_entries.create!(
    status: [0, 1].sample,
    user_id: User.first.id,
    habit_id: h2.id
  )
end

(1..10).to_a.each do |num|
  h3.habit_entries.create!(
    status: [0, 1].sample,
    user_id: User.first.id,
    habit_id: h3.id
  )
end

(1..20).to_a.each do |num|
  h4.habit_entries.create!(
    status: [0, 1].sample,
    user_id: User.first.id,
    habit_id: h4.id
  )
end

(1..30).to_a.each do |num|
  h5.habit_entries.create!(
    status: [0, 1].sample,
    user_id: User.first.id,
    habit_id: h5.id
  )
end

(1..12).to_a.each do |num|
  h6.habit_entries.create!(
    status: [0, 1].sample,
    user_id: User.first.id,
    habit_id: h6.id
  )
end

(1..15).to_a.each do |num|
  h7.habit_entries.create!(
    status: [0, 1].sample,
    user_id: User.first.id,
    habit_id: h7.id
  )
end

(1..10).to_a.each do |num|
  h8.habit_entries.create!(
    status: [0, 1].sample,
    user_id: User.first.id,
    habit_id: h8.id
  )
end

(1..20).to_a.each do |num|
  h9.habit_entries.create!(
    status: [0, 1].sample,
    user_id: User.first.id,
    habit_id: h9.id
  )
end

(1..10).to_a.each do |num|
  h10.habit_entries.create!(
    status: [0, 1].sample,
    user_id: User.first.id,
    habit_id: h10.id
  )
end
