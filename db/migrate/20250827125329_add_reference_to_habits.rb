class AddReferenceToHabits < ActiveRecord::Migration[7.1]
  def change
    add_reference :habits, :category
    remove_column :habits, :category
  end
end
