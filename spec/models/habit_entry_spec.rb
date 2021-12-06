require 'rails_helper'

RSpec.describe HabitEntry, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :habit }
  end

  describe 'mutations' do
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
    
    it 'does not duplicate neglected habits' do
      create(:habit_entry, user_id: @user.id, habit_id: @habit.id, status: 0)

      HabitEntry.create_neglected(@user, [])

      expect(@user.habit_entries.count).to eq(15)
    end

    it 'creates habit entries for completed habits' do
      HabitEntry.create_entries(@user, [{id: @habit.id}, {id: 2}])

      expect(@user.habit_entries.count).to eq(15)
      expect(@habit.habit_entries.first.status).to eq(1)
      expect(HabitEntry.last.status).to eq(0)
    end

    it 'can update habit entries' do
      HabitEntry.create_neglected(@user, [])

      HabitEntry.create_entries(@user, [{id: @habit.id}])

      expect(@user.habit_entries.count).to eq(15)
      expect(@habit.habit_entries.first.status).to eq(1)
    end

    it 'is date sensitive' do
      create(:habit_entry, user_id: @user.id, habit_id: @habit.id, created_at: Date.today - 1)

      HabitEntry.create_entries(@user, [{id: @habit.id}])

      expect(@user.habit_entries.count).to eq(16)
    end
  end

  describe 'daily completed' do
    let!(:user) { create :user }
    let!(:habits) { create_list :habit, 5 }
    let!(:completed_today) { create_list :habit_entry, 2, status: 1, user_id: user.id }
    let!(:incompleted_today) { create_list :habit_entry, 2, status: 0, user_id: user.id }
    let!(:completed_yesterday) { create_list :habit_entry, 2, status: 1, created_at: Date.today - 1, user_id: user.id }
    let!(:incompleted_yesterday) { create_list :habit_entry, 2, status: 0, created_at: Date.today - 1, user_id: user.id }

    it 'has all completed' do
      expect(user.habit_entries.completed).to eq(completed_today + completed_yesterday)
    end

    it 'has all completed today' do
      expect(user.habit_entries.daily_completed).to eq(completed_today.map(&:habit_id))
    end
  end

end
