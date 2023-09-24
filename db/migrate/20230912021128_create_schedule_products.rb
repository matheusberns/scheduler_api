class CreateScheduleProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :schedule_products do |t|
      t.float :price, default: 0.0, null: false
      t.integer :quantity, default: 1, null: false

      t.json :campos_personalizados
      t.uuid :uuid, index: true, null: false, default: 'uuid_generate_v4()', unique: true

      t.references :schedule, index: true, foreign_key: { to_table: :schedules }
      t.references :product, index: true, foreign_key: { to_table: :products }

      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.references :updated_by, index: true, foreign_key: { to_table: :users }

      t.boolean :active, index: true, default: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
