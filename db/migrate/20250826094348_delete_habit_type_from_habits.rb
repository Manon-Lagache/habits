class DeleteHabitTypeFromHabits < ActiveRecord::Migration[7.1]
  def change
    remove_column :habits, :habit_type
  end
end
