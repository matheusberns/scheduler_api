class EncryptTextService
  ENCRIPTION_KEY = SCHEDULER_ENCRIPTION_KEY

  def initialize(text_to_encrypt)
    @text_to_encrypt = text_to_encrypt
  end

  def call
    return if @text_to_encrypt.nil?

    encrypted_text
  end

  private

  def encrypted_text
    encryptor = ActiveSupport::MessageEncryptor.new(ENCRIPTION_KEY)

    encryptor.encrypt_and_sign(@text_to_encrypt)
  rescue StandardError => e
    ::Sentry.capture_exception(e)

    @text_to_encrypt
  end
end
