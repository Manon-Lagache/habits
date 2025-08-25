class CreateGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :goals do |t|
      t.references :habit, null: false, foreign_key: true
      t.string :value
      t.string :frequency
      t.date :target_day
      t.boolean :is_public
      t.string :status
      t.date :start_date
      t.date :end_date
      t.integer :progress

      t.timestamps
    end
  end
end
