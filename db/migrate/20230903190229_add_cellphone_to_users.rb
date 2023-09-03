class AddCellphoneToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :cellphone, :string, default: "", null: false
  end
end
