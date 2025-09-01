class AddReminderEnabledToHabits < ActiveRecord::Migration[7.1]
  def change
    add_column :habits, :reminder_enabled, :boolean
  end
end
