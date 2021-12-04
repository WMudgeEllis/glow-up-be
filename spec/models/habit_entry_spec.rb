require 'rails_helper'

RSpec.describe HabitEntry, type: :model do
  before :each do
    @user = create(:user)
    @habit = create(:habit)
    create_list(:habit, 14)
    create(:habit_entry, user_id: @user.id, habit_id: @habit.id, status: 1)
  end

  it 'creates habit entries for neglected habits' do
    HabitEntry.create_neglected(@user, [{id: @habit.id}])

    expect(@user.habit_entries.count).to eq(15)
    expect(HabitEntry.last.status).to eq(0)
  end
end
