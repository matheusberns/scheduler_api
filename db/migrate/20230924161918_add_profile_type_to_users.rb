class AddProfileTypeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :profile_type, :integer, default: 1
  end
end
