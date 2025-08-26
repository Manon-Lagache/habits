class AddHabitIdReferenceToTracker < ActiveRecord::Migration[7.1]
  def change
    add_reference :trackers, :habit
  end
end
