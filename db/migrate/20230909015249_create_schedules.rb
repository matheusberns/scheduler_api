class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
        t.datetime :scheduled_date, null: false
        t.integer :situation, default: 1, null: false
        t.float :discount, default: 0.0, null: false
        t.float :total, default: 0.0, null: false

        t.json :campos_personalizados
        t.uuid :uuid, index: true, null: false, default: 'uuid_generate_v4()', unique: true

        t.references :account, index: true, foreign_key: { to_table: :accounts }
        t.references :headquarter, index: true, foreign_key: { to_table: :headquarters }
        t.references :professional, index: true, foreign_key: { to_table: :users }
        t.references :customer, index: true, foreign_key: { to_table: :users }

        t.references :created_by, index: true, foreign_key: { to_table: :users }
        t.references :updated_by, index: true, foreign_key: { to_table: :users }

        t.boolean :active, index: true, default: true
        t.datetime :deleted_at, index: true

        t.timestamps
    end
  end
end
