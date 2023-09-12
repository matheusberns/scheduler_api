# frozen_string_literal: true

class Schedule < ApplicationRecord
  # Concerns
  include Age

  # Active storage
  attr_accessor :service_ids, :product_ids

  # Enumerations
  has_enumeration_for :situation, with: ::ScheduleSituationEnum, create_helpers: { prefix: true }, required: true

  # Belongs_to associations
  belongs_to :account, -> { activated }, class_name: '::Account', inverse_of: :schedules, foreign_key: :account_id, required: false
  belongs_to :headquarter, -> { activated }, class_name: '::Headquarter', inverse_of: :schedules, foreign_key: :headquarter_id, required: false

  # Has_many associations
  has_many :schedule_products, -> { activated }, class_name: '::ScheduleProduct', inverse_of: :schedule, foreign_key: :schedule_id
  has_many :schedule_services, -> { activated }, class_name: '::ScheduleService', inverse_of: :schedule, foreign_key: :schedule_id

  # Many-to-many associations

  # Has-many through

  # Scopes
  scope :list, lambda {
    select("#{table_name}.*")
      .select("#{::Headquarter.table_name}.name headquarter_name")
      .joins(:headquarter)
  }
  scope :show, lambda {
    select("#{table_name}.*")
      .select("#{::Headquarter.table_name}.name headquarter_name")
      .joins(:headquarter)
      .traceability
  }
  scope :by_situation, ->(situation) { where(situation: situation) }
  scope :by_date, lambda { |start_date, end_date|
    start_date = Date.parse(start_date).strftime('%Y-%m-%d') if start_date
    end_date = Date.parse(end_date).strftime('%Y-%m-%d') if end_date

    if start_date && end_date
      where("DATE(#{table_name}.scheduled_date) >= :start_date and DATE(#{table_name}.scheduled_date) <= :end_date", start_date: start_date, end_date: end_date)
    elsif start_date
      where("DATE(#{table_name}.scheduled_date) >= :start_date", start_date: start_date)
    elsif end_date
      where("DATE(#{table_name}.scheduled_date) <= :end_date", end_date: end_date)
    end
  }
  scope :by_headquarter_id, ->(headquarter_id) { where(headquarter_id: headquarter_id) }

  # Callbacks

  # Validations
end
