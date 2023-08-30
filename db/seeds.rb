# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

::Account.find_or_initialize_by(name: 'B-Systems').tap do |account|
  account.base_url = 'http://143.198.70.219'
  account.save!
end

::User.find_or_initialize_by(email: 'admin@b-systems.com.br').tap do |user|
  user.name = 'Administrador'
  user.password = '#Senha123'
  user.password_confirmation = '#Senha123'
  user.active = true
  user.account_id = Account.find_by(name: 'B-Systems').id
  user.deleted_at = nil
  user.cpf = '10281506957'
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