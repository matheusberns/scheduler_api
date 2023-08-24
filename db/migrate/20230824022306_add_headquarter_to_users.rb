class AddHeadquarterToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :headquarter, index: true, foreign_key: {to_table: :headquarters}
  end
end
