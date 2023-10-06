class AddDurationToScheduleServices < ActiveRecord::Migration[6.1]
  def change
    add_column :schedule_services, :duration, :integer
  end
end
