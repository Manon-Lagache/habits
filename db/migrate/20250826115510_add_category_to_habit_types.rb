class AddCategoryToHabitTypes < ActiveRecord::Migration[7.1]
  def change
    add_reference :habit_types, :category, null: false, foreign_key: true
  end
end
