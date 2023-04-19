# frozen_string_literal: true

class Service < ApplicationRecord
  # Concerns
  include Age

  # Active storage
  has_one_attached :image

  # Enumerations

  # Belongs_to associations
  belongs_to :account, -> { activated }, class_name: '::Account', inverse_of: :services, foreign_key: :account_id, required: false
  belongs_to :headquarter, -> { activated }, class_name: '::Headquarter', inverse_of: :services, foreign_key: :headquarter_id, required: false

  # Has_many associations

  # Many-to-many associations

  # Has-many through

  # Scopes
  scope :list, lambda {
    select("#{table_name}.*")
  }
  scope :show, lambda {
    select("#{table_name}.*")
      .traceability
  }
  scope :by_headquarter_id, ->(headquarter_id) { where(headquarter_id: headquarter_id) }
  # Callbacks

  # Validations
end
