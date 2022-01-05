module Queries
  class FetchUser < Queries::BaseQuery
    type Types::UserType, null: false

    argument :token, String, required: true

    def resolve(token:)
      User.find_by(id: decrypt(token))
    end

    private

    def decrypt(token)
      decrypted = crypt.decrypt_and_verify(token)
      decrypted.gsub('user-id:', '').to_i
    rescue ActiveSupport::MessageEncryptor::InvalidMessage
      raise GraphQL::ExecutionError, 'Invalid token'
    end

    def crypt
      ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31])
    end
  end
end
