# frozen_string_literal: true

class ScheduleProduct < ApplicationRecord
  # Concerns

  # Active storage

  # Enumerations

  # Belongs_to associations
  belongs_to :product, -> { activated }, class_name: '::Product', inverse_of: :schedule_products, foreign_key: :product_id
  belongs_to :schedule, -> { activated }, class_name: '::Schedule', inverse_of: :schedule_products, foreign_key: :schedule_id

  # Has_many associations

  # Many-to-many associations

  # Has-many through

  # Scopes
  scope :list, lambda {
    select("#{table_name}.*")
      .select("#{::Product.table_name}.name product_name")
      .select("#{::Product.table_name}.code product_code")
      .left_outer_joins(:product)
  }
  scope :show, lambda {
    select("#{table_name}.*")
      .select("#{::Product.table_name}.name product_name")
      .select("#{::Product.table_name}.code product_code")
      .left_outer_joins(:product)
      .traceability
  }

  # Callbacks

  # Validations
end
