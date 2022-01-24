module TokenGenerator
  def generate_token
    crypt.encrypt_and_sign("user-id:#{self.id}")
  end

  private

  def crypt
    ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31])
  end
end
