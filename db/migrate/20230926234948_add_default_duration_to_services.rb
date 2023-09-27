class AddDefaultDurationToServices < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :default_duration, :integer
  end
end
