require 'rails_helper'

RSpec.describe Journal, type: :model do
  it { should have_many :journal_entries }
end
