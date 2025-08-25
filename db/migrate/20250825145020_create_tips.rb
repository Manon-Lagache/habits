class CreateTips < ActiveRecord::Migration[7.1]
  def change
    create_table :tips do |t|
      t.references :user, null: false, foreign_key: true
      t.references :habit, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
