class DecryptTextService
  ENCRIPTION_KEY = SCHEDULER_ENCRIPTION_KEY

  def initialize(text_to_decrypt)
    @text_to_decrypt = text_to_decrypt
  end

  def call
    return if @text_to_decrypt.nil?

    decrypted_text
  end

  private

  def decrypted_text
    encryptor = ActiveSupport::MessageEncryptor.new(ENCRIPTION_KEY)

    result = encryptor.decrypt_and_verify(@text_to_decrypt)
    return result unless result.nil?

    raise DecryptionFailed
  end
end

class DecryptionFailed < StandardError; end
