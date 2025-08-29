class RemoveVerbFromHabitTypes < ActiveRecord::Migration[7.1]
  def change
    remove_column :habit_types, :verb, :string
  end
end
