class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :cpf, :string, index: true
    add_column :users, :username, :string, index: true
    add_column :users, :is_admin, :boolean, default: false
    add_column :users , :uuid, :uuid, default: 'gen_random_uuid()', index:  { unique: true }
    add_reference :users, :created_by, index: true, foreign_key: {to_table: :users}
    add_reference :users, :updated_by, index: true, foreign_key: {to_table: :users}
    add_column :users, :is_account_admin, :boolean, default: false
    add_column :users, :last_request_at, :datetime
    add_column :users, :remember_created_at, :datetime
    add_column :users, :timeout_in, :integer
    add_column :users, :allow_password_change, :boolean, default: false
    add_column :users, :is_integrator, :boolean, default: false
  end
end
