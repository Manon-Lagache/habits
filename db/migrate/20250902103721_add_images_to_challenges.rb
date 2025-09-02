class AddImagesToChallenges < ActiveRecord::Migration[7.1]
  def change
    add_column :challenges, :image, :string
  end
end
