require "rails_helper"

RSpec.describe ReminderMailer, type: :mailer do
  let(:user) { create(:user, email: 'example@example.example') }
  let(:mail) { ReminderMailer.reminder_email(user) }

  it 'can send reminder email' do
    expect(mail.subject).to eq('Reminding you about your journal')
    expect(mail.to).to eq([user.email])
  end
end
