# frozen_string_literal: true

class Mailer < ApplicationMailer
  default from: 'nao-responda@bsystems.net.br'
  layout false

  BCC = [].freeze

  def welcome(recipient)
    @user = recipient

    mail(to: recipient.email)
  end

  def reset_password(recipient, token)
    @user = recipient
    @token = token

    mail(to: recipient.email)
  end
end
