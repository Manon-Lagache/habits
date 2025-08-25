class CreateTrackers < ActiveRecord::Migration[7.1]
  def change
    create_table :trackers do |t|
      t.date :date
      t.float :value

      t.timestamps
    end
  end
end
