# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

::Account.find_or_initialize_by(name: 'Inspire Barber Studio').tap do |account|
  account.base_url = 'http://143.198.70.219'
  account.subdomain = 'inspire'
  account.save!
end

::Account.find_or_initialize_by(name: 'B-Systems').tap do |account|
  account.base_url = 'http://143.198.70.219'
  account.subdomain = 'bsystems'
  account.save!
end

::User.find_or_initialize_by(email: 'pablo@inspire.com').tap do |user|
  user.name = 'Pablo'
  user.password = '@Pablo2000'
  user.password_confirmation = '@Pablo2000'
  user.active = true
  user.account_id = Account.find_by(name: 'Inspire Barber Studio').id
  user.is_account_admin = true
  user.deleted_at = nil
  user.cpf = ''
  user.cellphone = '47991011904'
  user.save!
end

::User.find_or_initialize_by(email: 'account@bsystems.com').tap do |user|
  user.name = 'Admin Conta'
  user.password = '#Senha123'
  user.password_confirmation = '#Senha123'
  user.active = true
  user.account_id = Account.find_by(name: 'B-Systems').id
  user.is_account_admin = true
  user.deleted_at = nil
  user.cpf = ''
  user.cellphone = '47991011904'
  user.save!
end

::Integration.find_or_create_by({ token: 'f4f49fd6deed76678e60' }).tap do |integration|
  integration.description = 'B-Systems'
  integration.integration_type = IntegrationTypeEnum::WEB
  integration.account = Account.find_by(name: 'B-Systems')
  integration.active = true
  integration.save!
end

::Integration.find_or_create_by({ token: '189be8d598dcd88c0a4e' }).tap do |integration|
  integration.description = 'B-Systems'
  integration.integration_type = IntegrationTypeEnum::APP
  integration.account = Account.find_by(name: 'B-Systems')
  integration.active = true
  integration.save!
end