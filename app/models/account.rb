# frozen_string_literal: true

class Account < ApplicationRecord

  # Concerns

  # Active storage
  has_one_attached :logo
  has_one_attached :menu_background
  has_one_attached :toolbar_background

  # Enumerations

  # Belongs_to associations

  # Has_many associations
  has_many :services, class_name: '::Service', inverse_of: :account, foreign_key: :account_id
  has_many :products, class_name: '::Product', inverse_of: :account, foreign_key: :account_id
  has_many :users, class_name: '::User', inverse_of: :account, foreign_key: :account_id
  has_many :integrations, class_name: '::Integration', inverse_of: :account, foreign_key: :account_id, dependent: :destroy
  has_many :headquarters, class_name: '::Headquarter', inverse_of: :account, foreign_key: :account_id
  has_many :schedules, class_name: '::Schedule', inverse_of: :account, foreign_key: :account_id

  # Many-to-many associations
  has_many :all_account_tools, class_name: 'Many::AccountTool', foreign_key: :account_id, dependent: :destroy
  has_many :account_tools, -> { activated }, class_name: 'Many::AccountTool', inverse_of: :account, foreign_key: :account_id, dependent: :destroy
  has_many :tools, through: :account_tools

  # Has-many through

  # Scopes
  scope :list, lambda {
    select("#{table_name}.*")
  }
  scope :show, lambda {
    select("#{table_name}.*")
      .traceability
      .include_images
  }
  scope :autocomplete, lambda {
    select(:id, :name)
  }
  scope :by_name, lambda { |name|
    where("UNACCENT(#{table_name}.name) ILIKE :name",
          name: "%#{I18n.transliterate(name)}%")
  }
  scope :include_images, lambda {
    includes(logo_attachment: :blob)
    includes(menu_background_attachment: :blob)
    includes(toolbar_background_attachment: :blob)
  }
  scope :by_search, ->(search) { by_name(search) }
  scope :by_uuid, ->(uuid) { where("CAST(#{table_name}.uuid as TEXT) ILIKE :uuid", uuid: "%#{uuid}%") }

  # Callbacks
  after_create :default_setup
  before_save :encrypt_smtp_password

  # Validations
  validates :name, presence: true, length: { maximum: 255 }
  validates_uniqueness_of :uuid, conditions: -> { activated }
  validates_presence_of :subdomain

  def smtp_password
    ::DecryptTextService.new(read_attribute(:smtp_password)).call
  end

  private

  def default_setup
    ::AccountDefaultSetupJob.perform_now(self) unless Rails.env.test?
  end

  def encrypt_smtp_password
    return unless smtp_password_changed?

    write_attribute(:smtp_password, ::EncryptTextService.new(read_attribute(:smtp_password)).call)
  end

end
