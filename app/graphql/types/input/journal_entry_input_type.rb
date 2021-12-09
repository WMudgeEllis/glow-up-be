module Types
  module Input
    class JournalEntryInputType < Types::BaseInputObject
      argument :content, String, required: true
    end
  end
end
