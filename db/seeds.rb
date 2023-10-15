# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

::User.find_or_initialize_by(email: 'admin@scheduler.com.br').tap do |user|
  user.name = 'Admin'
  user.password = '@Senha123'
  user.password_confirmation = '@Senha123'
  user.active = true
  user.is_admin = true
  user.deleted_at = nil
  user.cpf = ''
  user.cellphone = '47111111111'
  user.save!
end

::Account.find_or_initialize_by(name: 'Barbearia Sandbox').tap do |account|
  account.base_url = 'http://143.198.70.219'
  account.subdomain = 'sandbox'
  account.save!

  account.headquarters.find_or_initialize_by(name: 'Matriz', cnpj: '40386101000167').tap do |headquarter|
    headquarter.name = 'sandbox'
    headquarter.save!
  end
end

::User.find_or_initialize_by(email: 'admin@sandbox.com.br').tap do |user|
  user.name = 'Admin Barbearia Sandbox'
  user.password = '@Senha123'
  user.password_confirmation = '@Senha123'
  user.active = true
  user.account_id = Account.find_by(name: 'Barbearia Sandbox').id
  user.is_account_admin = true
  user.deleted_at = nil
  user.cpf = ''
  user.cellphone = '47777777777'
  user.save!
end

::User.find_or_initialize_by(email: 'cliente@gmail.com').tap do |user|
  user.name = 'Cliente'
  user.password = '@Senha123'
  user.password_confirmation = '@Senha123'
  user.active = true
  user.account_id = Account.find_by(name: 'Barbearia Sandbox').id
  user.headquarter_id = 1
  user.is_account_admin = false
  user.deleted_at = nil
  user.cpf = ''
  user.cellphone = '47999999999'
  user.profile_type = ProfileTypeEnum::CUSTOMER
  user.save!
end

::User.find_or_initialize_by(email: 'profissional@gmail.com').tap do |user|
  user.name = 'Profissional'
  user.password = '@Senha123'
  user.password_confirmation = '@Senha123'
  user.active = true
  user.account_id = Account.find_by(name: 'Barbearia Sandbox').id
  user.headquarter_id = 1
  user.is_account_admin = false
  user.deleted_at = nil
  user.cpf = ''
  user.cellphone = '47888888888'
  user.profile_type = ProfileTypeEnum::CUSTOMER
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