class RemoveInformationsFromChallenges < ActiveRecord::Migration[7.1]
  def change
    remove_column :challenges, :informations, :text
  end
end
