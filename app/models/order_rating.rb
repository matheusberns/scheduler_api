# frozen_string_literal: true

class OrderRating < ApplicationRecord
  # Concerns

  # Active storage

  # Enumerations
  has_enumeration_for :rating_type, with: ::RatingTypeEnum, create_helpers: { prefix: true }, required: false

  # Belongs_to associations
  belongs_to :account, -> { activated }, class_name: '::Account', inverse_of: :order_ratings, foreign_key: :account_id, required: false
  belongs_to :headquarter, -> { activated }, class_name: '::Headquarter', inverse_of: :order_ratings, foreign_key: :headquarter_id, required: false
  belongs_to :order, -> { activated }, class_name: '::Schedule', inverse_of: :order_ratings, foreign_key: :order_id, required: false

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

  # Callbacks

  # Validations
  validates :rating, presence: true
  validates :description, presence: true
end
