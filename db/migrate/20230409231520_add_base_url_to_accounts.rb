class AddBaseUrlToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :base_url, :string, limit: 100
  end
end
