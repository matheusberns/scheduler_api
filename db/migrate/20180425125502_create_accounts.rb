class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    # enable_extension 'unaccent'
    # enable_extension 'uuid-ossp'
    # enable_extension 'pgcrypto'

    create_table :accounts do |t|
      t.string :name, null: false, index: true

      t.boolean :active, index: true, default: true
      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end
