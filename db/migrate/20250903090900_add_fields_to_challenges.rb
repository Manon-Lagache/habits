class AddFieldsToChallenges < ActiveRecord::Migration[7.1]
  def change
    add_column :challenges, :description, :text
    add_column :challenges, :objective, :string
    add_column :challenges, :start_date, :date
    add_column :challenges, :end_date, :date
    add_column :challenges, :xp_reward, :integer
  end
end
