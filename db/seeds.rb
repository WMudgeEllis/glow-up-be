User.destroy_all
Journal.destroy_all
JournalEntry.destroy_all
Habit.destroy_all
HabitEntry.destroy_all

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

user = User.create!(
  username: 'User',
  password: 'hello',
  password_confirmation: 'hello',
  email: 'generic.address@custom.com'
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

(1..10).to_a.sample(3).each do |num|
  JournalEntry.create!(
    date: Date.today - num,
    content: 'Today I felt like journaling',
    user_id: User.first.id,
    journal: j
  )
end

h1 = Habit.create!(name: 'Exercise')
h2 = Habit.create!(name: 'Meditate')
h3 = Habit.create!(name: 'Floss')
h4 = Habit.create!(name: 'Brush teeth x2')
h5 = Habit.create!(name: 'Drink Water')
h6 = Habit.create!(name: 'Socialize')
h7 = Habit.create!(name: 'Eat Healthy')
h8 = Habit.create!(name: 'Wash Dishes')
h9 = Habit.create!(name: 'Write in Journal')
h10 = Habit.create!(name: 'Take a Shower')
h11 = Habit.create!(name: 'Stay off Social Media')
h12 = Habit.create!(name: 'Make Bed')
h13 = Habit.create!(name: 'Read')
h14 = Habit.create!(name: 'Go Outside')
h15 = Habit.create!(name: 'Plan Tomorrow')



(1..7).to_a.sample(3).each do |num|
  h1.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h1.id
  )
end

(1..7).to_a.sample(3).each do |num|
  h2.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h2.id
  )
end

(1..7).to_a.sample(3).each do |num|
  h3.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h3.id
  )
end

(1..7).to_a.sample(3).each do |num|
  h4.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h4.id
  )
end

(1..7).to_a.sample(3).each do |num|
  h5.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h5.id
  )
end

(1..7).to_a.sample(3).each do |num|
  h6.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h6.id
  )
end

(1..7).to_a.sample(3).each do |num|
  h7.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h7.id
  )
end

(1..7).to_a.sample(3).each do |num|
  h8.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h8.id
  )
end

(1..7).to_a.sample(3).each do |num|
  h9.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h9.id
  )
end

(1..7).to_a.sample(3).each do |num|
  h10.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h10.id
  )
end

(1..10).to_a.sample(3).each do |num|
  h11.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h11.id
  )
end

(1..10).to_a.sample(3).each do |num|
  h12.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h12.id
  )
end

(1..10).to_a.sample(3).each do |num|
  h13.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h13.id
  )
end

(1..10).to_a.sample(3).each do |num|
  h14.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h14.id
  )
end

(1..10).to_a.sample(3).each do |num|
  h15.habit_entries.create!(
    created_at: Date.today - num,
    user_id: User.first.id,
    habit_id: h15.id
  )
end
