# frozen_string_literal: true

class Headquarter < ApplicationRecord
  # Concerns

  # Active storage

  # Enumerations

  # Belongs_to associations
  belongs_to :account, -> { activated }, class_name: '::Account', inverse_of: :headquarters, foreign_key: :account_id

  # Has_many associations
  has_many :services, class_name: '::Service', inverse_of: :headquarter, foreign_key: :headquarter_id

  # Many-to-many associations

  # Has-many through

  # Scopes
  scope :list, lambda {
    select("#{table_name}.*")
  }
  scope :show, lambda {
    select("#{table_name}.*")
  }
  scope :autocomplete, lambda {
    select("#{table_name}.*")
  }

  # Callbacks

  # Validations

  # def create_user(email: nil, password: nil)
  #   user = users.find_or_initialize_by({ headquarter_id: id })
  #
  #   user.is_new_user = email != user.email ? true : false
  #   user.account_id = account_id
  #   user.name = name
  #   user.email = email
  #   user.password_confirmation = password
  #   user.password = password
  #   user.active = true
  #   user.deleted_at = nil
  #
  #   user.save
  # end
end
