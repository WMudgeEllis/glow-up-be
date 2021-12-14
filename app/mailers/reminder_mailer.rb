class ReminderMailer < ApplicationMailer

  def reminder_email(user)
    @user = user
    mail(to: @user.email, subject: 'Reminding you about your journal')
  end
end
