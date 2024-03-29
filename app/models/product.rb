# frozen_string_literal: true

class Product < ApplicationRecord
  # Concerns

  # Active storage
  has_one_attached :file

  # Enumerations

  # Belongs_to associations
  belongs_to :account, -> { activated }, class_name: '::Account', inverse_of: :products, foreign_key: :account_id

  # Has_many associations
  has_many :schedule_products, class_name: 'Many::ScheduleProduct', inverse_of: :products, foreign_key: :product_id

  # Many-to-many associations

  # Has-many through

  # Scopes
  scope :list, lambda {
    select("#{table_name}.*")
      .select("#{::Account.table_name}.name account_name")
      .joins(:account)
  }
  scope :show, lambda {
    select("#{table_name}.*")
      .select("#{::Account.table_name}.name account_name")
      .joins(:account)
      .traceability
  }
  scope :by_search, lambda { |search|
    if search.present?
      where("unaccent(#{table_name}.code) ILIKE :search", search: "%#{I18n.transliterate(search)}%")
        .or(where("unaccent(#{table_name}.name) ILIKE :search", search: "%#{I18n.transliterate(search)}%"))
    end
  }

  # Callbacks

  # Validations
  validates_uniqueness_of :code
end
