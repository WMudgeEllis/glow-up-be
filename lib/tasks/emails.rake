namespace :emails do

  desc 'send reminder email'
  task reminder_email: :environment do
    User.all.each do |user|
      ReminderMailer.reminder_email(user).deliver_now if user.habit_entries.daily_completed.empty? || !user.daily_mood
    end
  end

end
