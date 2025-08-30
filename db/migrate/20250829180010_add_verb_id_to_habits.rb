class AddVerbIdToHabits < ActiveRecord::Migration[7.1]
  def change
    add_column :habits, :verb_id, :bigint
  end
end
