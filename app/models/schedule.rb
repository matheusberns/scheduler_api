# frozen_string_literal: true

class Schedule < ApplicationRecord
  # Concerns
  include Age

  # Active storage
  attr_accessor :services, :products

  # Enumerations
  has_enumeration_for :situation, with: ::ScheduleSituationEnum, create_helpers: { prefix: true }, required: true

  # Belongs_to associations
  belongs_to :account, -> { activated }, class_name: '::Account', inverse_of: :schedules, foreign_key: :account_id, required: false
  belongs_to :headquarter, -> { activated }, class_name: '::Headquarter', inverse_of: :schedules, foreign_key: :headquarter_id, required: false
  belongs_to :customer, class_name: '::User', inverse_of: :schedules, foreign_key: :customer_id, required: false

  # Has_many associations
  has_many :schedule_products, class_name: 'Many::ScheduleProduct', inverse_of: :schedule, foreign_key: :schedule_id, dependent: :destroy
  has_many :schedule_services, class_name: 'Many::ScheduleService', inverse_of: :schedule, foreign_key: :schedule_id, dependent: :destroy

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
      .includes(:schedule_services, :schedule_products)
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
  scope :by_headquarter_id, ->(current_user) {
    where(headquarter_id: current_user.headquarter_id) if current_user.headquarter_id
  }

  # Callbacks
  after_commit :set_services, :set_products

  # Validations
  validates_presence_of :scheduled_date

  def set_services
    return if services.nil?

    services.each do |service|
      schedule_service = schedule_services.find_or_initialize_by(service_id: service['id'])
      schedule_service.price = service['price']
      schedule_service.duration = service['duration']
      schedule_service.active = true
      schedule_service.deleted_at = nil
      schedule_service.save!
    end

    schedule_services.where.not(service_id: services).destroy_all
  end

  # TODO Refatorar para classe de service.
  def set_products
    return if products.nil?

    products.each do |product|
      schedule_product = schedule_products.find_or_initialize_by(product_id: product['id'])
      schedule_product.price = product['price']
      schedule_product.active = true
      schedule_product.deleted_at = nil
      schedule_product.save!
    end

    schedule_products.where.not(product_id: products).destroy_all
  end
end
