class AddDefaultAvatarToUser < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :avatar, from: nil, to: "profile-user.png"
  end
end
