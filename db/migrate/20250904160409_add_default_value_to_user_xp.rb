class AddDefaultValueToUserXp < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :xp_reward, from: nil, to: 100

  end
end
