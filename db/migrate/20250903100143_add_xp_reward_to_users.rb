class AddXpRewardToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :xp_reward, :integer
  end
end
