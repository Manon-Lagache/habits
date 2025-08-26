class AddHabitTypeToHabits < ActiveRecord::Migration[7.1]
  def change
    add_reference :habits, :habit_type, foreign_key: true
  end
end
