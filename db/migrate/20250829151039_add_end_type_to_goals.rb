class AddEndTypeToGoals < ActiveRecord::Migration[7.1]
  def change
    add_column :goals, :end_type, :string
  end
end
