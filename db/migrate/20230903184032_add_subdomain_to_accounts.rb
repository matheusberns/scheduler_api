class AddSubdomainToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :subdomain, :string, default: ''
  end
end
