class AddInfosToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :pseudo, :string
    add_column :users, :avatar, :string
    add_column :users, :age, :integer
    add_column :users, :location, :string
  end
end
