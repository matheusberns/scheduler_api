class CreateHeadquarters < ActiveRecord::Migration[6.1]
  def change
    create_table :headquarters do |t|
      t.string :cnpj, default: "", null: false
      t.string :name, default: "", null: false
      t.json :campos_personalizados
      t.uuid :uuid, index: true, null: false, default: 'uuid_generate_v4()', unique: true

      t.references :account, index: true, foreign_key: { to_table: :accounts }
      t.references :state, index: true, foreign_key: { to_table: :state_id }
      t.references :city, index: true, foreign_key: { to_table: :city_id }
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.references :updated_by, index: true, foreign_key: { to_table: :users }

      t.boolean :active, index: true, default: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
