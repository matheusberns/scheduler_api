class AddUserFieldsToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_reference :accounts, :created_by, foreign_key: { to_table: :users }
    add_reference :accounts, :updated_by, foreign_key: { to_table: :users }
  end
end
