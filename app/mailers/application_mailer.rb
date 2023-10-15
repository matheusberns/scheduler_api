class ApplicationMailer < ActionMailer::Base
  default from: 'nao-responda@bsystems.net.br'
  layout false

  def self.account_delivery_options(account)
    return { from: 'nao-responda@bsystems.net.br' } if account.nil? || Rails.env.development? || Rails.env.test?

    {
      from: account.smtp_email,
      user_name: account.smtp_user,
      password: account.smtp_password,
      address: account.smtp_host,
      port: 465,
      authentication: :login,
      enable_starttls_auto: true,
      openssl_verify_mode: 'none'
    }
  end
end
