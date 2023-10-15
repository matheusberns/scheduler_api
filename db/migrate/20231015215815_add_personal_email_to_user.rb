class AddPersonalEmailToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :personal_email, :string
  end
end
