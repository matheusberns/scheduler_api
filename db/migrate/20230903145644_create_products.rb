class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :code, default: "", null: false
      t.string :name, default: "", null: false
      t.string :description, default: "", null: false
      t.float :suggested_price, default: 0.0, null: false
      t.json :campos_personalizados
      t.uuid :uuid, index: true, null: false, default: 'uuid_generate_v4()', unique: true

      t.references :account, index: true, foreign_key: { to_table: :accounts }
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.references :updated_by, index: true, foreign_key: { to_table: :users }

      t.boolean :active, index: true, default: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
