module Overrides
  class Mailer < Devise::Mailer
    # helper :application # gives access to all helpers defined within `application_helper`.
    include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
    default template_path: 'devise/mailer'

    def reset_password_instructions(record, token, opts = {})
      @token = token
      @resource = record
      @opts = opts

      delivery_options = ApplicationMailer.account_delivery_options(record&.account)

      mail(
        subject: 'Recuperação de senha',
        to: opts[:to],
        from: delivery_options[:from],
        delivery_method_options: delivery_options
      )
    end

    def unlock_instructions(record, token, opts = {})
      record_account = record.account
      delivery_options = ApplicationMailer.account_delivery_options(record_account)

      opts[:delivery_method_options] = delivery_options
      opts[:from] = delivery_options[:from]
      opts[:subject] = "#{record_account&.name || 'JoinIn'} - Instruções de desbloqueio"

      super(record, token, opts)
    end

    def first_access(record, temporary_password, opts = {})
      @resource = record
      @account = @resource.account
      @opts = opts
      @temporary_password = temporary_password

      delivery_options = ApplicationMailer.account_delivery_options(record&.account)

      mail(
        subject: I18n.t('devise.mailer.first_access.subject', account_name: @account.project_name || 'JoinIn'),
        to: @resource.email,
        from: delivery_options[:from],
        delivery_method_options: delivery_options
      )
    end
  end
end
