require 'rails_helper'

RSpec.describe JournalEntry, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :journal }
  end
end
