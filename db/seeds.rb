# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

::Account.find_or_initialize_by(name: 'B-Systems').tap do |account|
  account.base_url 'http://147.182.164.43'
  account.save!
end

::User.find_or_initialize_by(email: 'admin@bsystems.com.br').tap do |user|
  user.name = 'Administrador'
  user.password = '#Senha123'
  user.password_confirmation = '#Senha123'
  user.active = true
  user.account_id = Account.find_by(name: 'B-Systems')
  user.deleted_at = nil
  user.cpf = '10281506957'
  user.save!
end