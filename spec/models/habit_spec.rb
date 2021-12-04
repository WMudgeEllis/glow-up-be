require 'rails_helper'

RSpec.describe Habit, type: :model do
  describe 'relationships' do
    it { should have_many :habit_entries }
  end
end
