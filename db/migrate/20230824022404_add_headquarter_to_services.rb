class AddHeadquarterToServices < ActiveRecord::Migration[6.1]
  def change
    add_reference :services, :headquarter, index: true, foreign_key: {to_table: :headquarters}
  end
end
