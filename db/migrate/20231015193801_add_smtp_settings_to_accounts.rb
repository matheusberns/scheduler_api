class AddSmtpSettingsToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :smtp_user, :string
    add_column :accounts, :smtp_password, :string
    add_column :accounts, :smtp_host, :string
    add_column :accounts, :smtp_email, :string
    add_column :accounts, :smtp_ssl, :boolean, default: false
  end
end
