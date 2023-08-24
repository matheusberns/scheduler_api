class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.string :name, index: true, null: false
      t.string :description, index: true, null: false
      t.json :campos_personalizados
      t.uuid :uuid, index: true, null: false, default: 'uuid_generate_v4()', unique: true

      t.references :headquarter, index: true, foreign_key: { to_table: :headquarters }
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.references :updated_by, index: true, foreign_key: { to_table: :users }

      t.boolean :active, index: true, default: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
