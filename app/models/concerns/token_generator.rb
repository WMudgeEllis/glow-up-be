module TokenGenerator
  def generate_token
    crypt.encrypt_and_sign("user-id:#{self.id}")
  end

  private

  def crypt
    if Rails.env.production?
      ActiveSupport::MessageEncryptor.new(ENV['SECRET_KEY_BASE'][0..31])
    else
      ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31])
    end
  end
end
