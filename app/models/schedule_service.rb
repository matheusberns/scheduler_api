# frozen_string_literal: true

class ScheduleService < ApplicationRecord
  # Concerns

  # Active storage

  # Enumerations

  # Belongs_to associations
  belongs_to :service, -> { activated }, class_name: '::Service', inverse_of: :schedule_services, foreign_key: :service_id
  belongs_to :schedule, -> { activated }, class_name: '::Schedule', inverse_of: :schedule_services, foreign_key: :schedule_id

  # Has_many associations

  # Many-to-many associations

  # Has-many through

  # Scopes
  scope :list, lambda {
    select("#{table_name}.*")
      .select("#{::Service.table_name}.name service_name")
      .select("#{::Service.table_name}.code service_code")
      .left_outer_joins(:service)
  }
  scope :show, lambda {
    select("#{table_name}.*")
      .select("#{::Service.table_name}.name service_name")
      .select("#{::Service.table_name}.code service_code")
      .left_outer_joins(:service)
      .traceability
  }

  # Callbacks

  # Validations
end
